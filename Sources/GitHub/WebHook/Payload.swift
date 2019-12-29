import Foundation

public protocol GitHubPayload: PayloadType { }
extension GitHubPayload {
    public init?(_ data: Data) {
        do {
            self = try GitHubHook.decoder.decode(Self.self, from: data)
        } catch {
            SwiftHooks.logger.debug("Decoding error: \(error), \(error.localizedDescription)")
            return nil
        }
    }
}
