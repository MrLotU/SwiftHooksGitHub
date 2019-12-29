public struct IssueComment: GitHubPayload {
    public enum IssueAction: String, Codable {
        case created, edited, deleted
    }
    public let action: IssueAction
    public let issue: Issue
    public let comment: Comment
    public let repository: Repository
    public let sender: User
}

extension IssueComment: Messageable {
    public var channel: Channelable {
        self.issue
    }
    
    public var content: String {
        self.comment.body
    }
    
    public var author: Userable {
        self.sender
    }
    
    public func reply(_ content: String) {}
    public func edit(_ content: String) {}
    public func delete() {}
}

public struct Issues: GitHubPayload {
    public enum IssuesAction: String, Codable {
        case opened, edited, deleted, pinned, unpinned, closed
        case reopened, assigned, unassigned, labeled, unlabeled
        case locked, unlocked, transferred, milestoned, demilestoned
    }
    let action: IssuesAction
    let issue: Issue
    let changes: Changes
    let repository: Repository
    let sender: User
}

public struct PullRequestEvent: GitHubPayload {
    public enum PullRequestAction: String, Codable {
        case assigned, unassigned, reviewRequested, reviewRequestRemoved
        case labeled, unlabeled, opened, edited, closed, readyForReview
        case locked, unlocked, reopened
    }
    let action: PullRequestAction
    let number: Int
    let changes: Changes
    let pullRequest: PullRequest
    let repository: Repository
    let sender: User
}
