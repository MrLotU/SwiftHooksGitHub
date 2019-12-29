public struct Comment: Codable {
    public let url: String
    public let htmlUrl: String
    public let issueUrl: String
    public let id: Int
    public let nodeId: String
    public let user: User
    public let createdAt: String
    public let updatedAt: String
    public let authorAssociation: String
    public let body: String
}
