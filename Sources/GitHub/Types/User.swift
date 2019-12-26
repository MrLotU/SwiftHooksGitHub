public struct User: Codable {
    public let login: String
    public let id: Int
    public let nodeId: String
    public let avatarUrl: String
    public let gravatarId: String
    public let url: String
    public let htmlUrl: String
    public let followersUrl: String
    public let followingUrl: String
    public let gistsUrl: String
    public let starredUrl: String
    public let subscriptionsUrl: String
    public let organizationsUrl: String
    public let reposUrl: String
    public let eventsUrl: String
    public let receivedEventsUrl: String
    public let type: String
    public let siteAdmin: Bool
}

extension User: Userable {
    public var identifier: String? {
        "\(id)"
    }
    public var mention: String {
        "@\(login)"
    }
}
