import Foundation
import Vapor
import NIO

extension HookID {
    static let gitHub: HookID = .init(identifier: "GitHub")
}

public final class GitHubHook: Hook {
    public typealias Options = GitHubHookOptions
    
    public init(_ options: GitHubHookOptions, hooks: SwiftHooks?) {
        self.hooks = hooks
    }
    
    public func boot(on elg: EventLoopGroup) throws {
        let app = Application(.custom(name: "SwiftHooks"), .shared(elg))
        self.app = app
        self.registerEndpoint(to: app)
        try app.run()
    }
    
    public func shutdown() {
        self.app?.shutdown()
    }
    
    public var hooks: SwiftHooks?
    private var app: Application?
    
    public static let id: HookID = .gitHub
    
    public let translator: EventTranslator.Type = GitHubEventTranslator.self
    
    public func listen<T, I>(for event: T, handler: @escaping (I) throws -> Void) where T : _Event, I == T.ContentType {
        
    }
    
    public func dispatchEvent<E>(_ event: E, with raw: Data) where E : EventType {
        defer {
            self.hooks?.dispatchEvent(event, with: raw, from: self)
        }
        print("Received \(event) with \(raw)")
    }
}

public struct GitHubHookOptions: HookOptions {
    public init() { }
}

enum GitHubEventTranslator: EventTranslator {
    static func translate<E>(_ event: E) -> GlobalEvent? where E : EventType {
        return nil
    }
    
    static func decodeConcreteType<T>(for event: GlobalEvent, with data: Data, as t: T.Type) -> T? {
        return nil
    }
}
