public struct PullRequest: Codable {
    public let url: String
    public let id: Int
    public let nodeId: String
    public let htmlUrl: String
    public let diffUrl: String
    public let patchUrl: String
    public let issueUrl: String
    public let number: Int
    public let state: String
    public let locked: Bool
    public let title: String
    public let user: User
    public let body: String
    public let createdAt: String
    public let updatedAt: String
    public let closedAt: String?
    public let mergedAt: String?
    public let mergeCommitSha: String?
    public let assignee: User?
    public let assignees: [User]
    public let requestedReviewer: User?
    public let requestedReviewers: [User]
    public let requestedTeams: [Unimplemented]
    public let labels: [Label]
    public let milestone: Milestone?
    public let commitsUrl: String
    public let reviewCommentsUrl: String
    public let reviewCommentUrl: String
    public let commentsUrl: String
    public let statusesUrl: String
    public let head: Branch
    public let base: Branch
    public let links: Links
    public let authorAssociation: String
    public let draft: Bool
    public let merged: Bool
    public let mergeable: Bool?
    public let rebaseable: Bool?
    public let mergeableState: String
    public let mergedBy: User?
    public let comments: Int
    public let reviewComments: Int
    public let maintainerCanModify: Bool
    public let commits: Int
    public let additions: Int
    public let deletions: Int
    public let changedFiles: Int
}

public struct Branch: Codable {
    public let label: String
    public let ref: String
    public let sha: String
    public let user: User
    public let repo: Repository
}

public struct Link: Codable {
    public let href: String
}

public struct Links: Codable {
    public let linksSelf: Link
    public let html: Link
    public let issue: Link
    public let comments: Link
    public let reviewComments: Link
    public let reviewComment: Link
    public let commits: Link
    public let statuses: Link
}
