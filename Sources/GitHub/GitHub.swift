import Foundation
import Vapor
import NIO

extension HookID {
    static let gitHub: HookID = .init(identifier: "GitHub")
}

public typealias GitHub = GitHubEvent

public final class GitHubHook: Hook {
    public typealias Options = GitHubHookOptions
    
    public init(_ options: GitHubHookOptions, _ elg: EventLoopGroup) {
        self.eventLoopGroup = elg
        self.options = options
        self.githubListeners = [:]
        self.lock = Lock()
    }
    
    public func boot(hooks: SwiftHooks? = nil) throws {
        self.hooks = hooks
        let app: Application
        switch options {
        case .createApp(let host, let port):
            app = Application(.custom(name: "SwiftHooks"), .shared(self.eventLoopGroup))
            app.server.configuration.hostname = host
            app.server.configuration.port = port
        case .shared(let sharedApp):
            app = sharedApp
        }
        self.app = app
        self.registerEndpoint(to: app)
        try app.run()
    }
    
    public func shutdown() {
        self.app?.shutdown()
        self.lock.withLockVoid {
            self.githubListeners = [:]
            self.app = nil
            self.hooks = nil
        }
    }
    
    static var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
    
    private let options: GitHubHookOptions
    public private(set) var hooks: SwiftHooks?
    public let eventLoopGroup: EventLoopGroup
    private var app: Application?
    private let lock: Lock
    public internal(set) var githubListeners: [GitHubEvent: [EventClosure]]
    
    public static let id: HookID = .gitHub
    
    public func listen<T, I, D>(for event: T, handler: @escaping EventHandler<D, I>) where T : _Event, I == T.ContentType, T.D == D {
        guard let event = event as? _GitHubEvent<I> else { return }
        lock.withLockVoid {
            var closures = self.githubListeners[event, default: []]
            closures.append { (data) in
                guard let object = I.create(from: data, on: self) else {
                    SwiftHooks.logger.debug("Unable to extract \(I.self) from data.")
                    return
                }
                guard let d = D.init(self) else {
                    SwiftHooks.logger.debug("Unable to wrap \(I.self) in \(D.self) dispatch.")
                    return
                }
                try handler(d, object)
            }
            self.githubListeners[event] = closures
        }
    }
    
    public func dispatchEvent<E>(_ event: E, with raw: Data) where E : EventType {
        defer {
            self.hooks?.dispatchEvent(event, with: raw, from: self)
        }
        guard let event = event as? GitHubEvent else { return }
        lock.withLockVoid {
            let handlers = self.githubListeners[event]
            handlers?.forEach { handler in
                do {
                    try handler(raw)
                } catch {
                    SwiftHooks.logger.error("\(error.localizedDescription)")
                }
            }
        }
    }
    
    public func translate<E>(_ event: E) -> GlobalEvent? where E : EventType {
        guard let event = event as? GitHubEvent else { return nil }
        switch event {
        case ._issueComment:
            return ._messageCreate
        default:
            return nil
        }
    }
    
    public func decodeConcreteType<T>(for event: GlobalEvent, with data: Data, as t: T.Type) -> T? {
        switch event {
        case ._messageCreate:
            return IssueComment.create(from: data, on: self) as? T
            //        default:
            //            return nil
        }
    }
}

public enum GitHubHookOptions: HookOptions {
    case createApp(host: String, port: Int)
    case shared(app: Application)
}
