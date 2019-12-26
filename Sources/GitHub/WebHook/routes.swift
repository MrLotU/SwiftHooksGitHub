import Vapor

extension GitHubHook {
    func registerEndpoint(to app: Application) {
        app.post("github", "webhook", use: handleWebhook)
    }

    func handleWebhook(_ req: Request) -> EventLoopFuture<HTTPStatus> {
        guard
            let eventString = req.headers.first(name: "X-GitHub-Event"),
            let event = GitHubEvent(rawValue: eventString)
        else { print(req.headers);return req.eventLoop.makeSucceededFuture(.ok) }
        
        return req.body.collect().map { optionalBuffer in
            guard var buffer = optionalBuffer, let data = buffer.readData(length: buffer.readableBytes) else { return .ok }
            self.dispatchEvent(event, with: data)
            return .ok
        }
    }
}
