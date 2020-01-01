import Foundation

public protocol GitHubPayload: PayloadType { }
extension GitHubPayload {
    public static func create(from data: Data) -> GitHubPayload? {
        do {
            return try GitHubHook.decoder.decode(Self.self, from: data)
        } catch {
            SwiftHooks.logger.debug("Decoding error: \(error), \(error.localizedDescription)")
            return nil
        }
    }
}
