public struct Issue: Codable {
    public let url: String
    public let repositoryUrl: String
    public let labelsUrl: String
    public let commentsUrl: String
    public let eventsUrl: String
    public let htmlUrl: String
    public let id: Int
    public let nodeId: String
    public let number: Int
    public let title: String
    public let user: User
    public let labels: [Label]
    public let state: String
    public let locked: Bool
    public let assignee: User
    public let assignees: [User]
    public let milestone: Milestone
    public let comments: Int
    public let createdAt: String
    public let updatedAt: String
    public let closedAt: String?
    public let authorAssociation: String
    public let body: String
}

extension Issue: Channelable {
    public var mention: String {
        self.htmlUrl
    }
    
    public func send(_ msg: String) { }
}

public struct Changes: Codable {
    public struct IssueFrom: Codable {
        public let from: String
    }
    let title: IssueFrom
    let body: IssueFrom
}

public struct Milestone: Codable {
    public let url: String
    public let htmlUrl: String
    public let labelsUrl: String
    public let id: Int
    public let nodeId: String
    public let number: Int
    public let title: String
    public let description: String
    public let creator: User
    public let openIssues: Int
    public let state: String
    public let createdAt: String
    public let updatedAt: String
    public let dueOn: String
    public let closedAt: String
}

public struct Label: Codable {
    public let id: Int
    public let nodeId: String
    public let url: String
    public let name: String
    public let color: String
    public let `default`: Bool
}
