import Foundation

public protocol GitHubPayload: PayloadType { }
public extension GitHubPayload {
    static func create(from data: Data, on h: _Hook) -> Self? {
        do {
            return try GitHubHook.decoder.decode(Self.self, from: data)
        } catch {
            SwiftHooks.logger.debug("Decoding error: \(error), \(error.localizedDescription)")
            return nil
        }
    }
}
