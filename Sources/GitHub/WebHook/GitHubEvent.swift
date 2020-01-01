import Foundation

public struct _GitHubEvent<E: EventType, ContentType: PayloadType>: _Event {
    public let event: E
    public typealias Hook = GitHubHook
    public init(_ e: E, _ t: ContentType.Type) {
        self.event = e
    }
}

public enum GitHubEvent: String, Codable, EventType {
    case _ping = "ping"
    case _checkRun = "check_run"
    case _checkSuite = "check_suite"
    case _commitComment = "commit_comment"
    case _contentReference = "content_reference"
    case _create = "create"
    case _delete = "delete"
    case _deployKey = "deploy_key"
    case _deployment = "deployment"
    case _deploymentStatus = "deployment_status"
    case _fork = "fork"
    case _githubAppAuthorize = "github_app_authorize"
    case _gollum = "gollum"
    case _installation = "installation"
    case _installationRepositories = "installation_repositories"
    case _issueComment = "issue_comment"
    case _issues = "issues"
    case _label = "label"
    case _marketplacePurchase = "marketplace_purchase"
    case _member = "member"
    case _membership = "membership"
    case _meta = "meta"
    case _milestone = "milestone"
    case _organization = "organization"
    case _orgBlock = "org_block"
    case _pageBuild = "page_build"
    case _projectCard = "project_card"
    case _projectColumn = "project_column"
    case _project = "project"
    case _public = "public"
    case _pullRequest = "pull_request"
    case _pullRequestReview = "pull_request_review"
    case _pullRequestReviewComment = "pull_request_review_comment"
    case _push = "push"
    case _package = "package"
    case _release = "release"
    case _repository = "repository"
    case _repositoryImport = "repository_import"
    case _repositoryVulnerabilityAlert = "repository_vulnerability_alert"
    case _securityAdvisory = "security_advisory"
    case _star = "star"
    case _status = "status"
    case _team = "team"
    case _teamAdd = "team_add"
    case _watch = "watch"
    
    public static let issues = _GitHubEvent(GitHubEvent._issues, Issues.self)
    public static let issueComment = _GitHubEvent(GitHubEvent._issueComment, IssueComment.self)
    public static let pullRequest = _GitHubEvent(GitHubEvent._pullRequest, PullRequestEvent.self)
}

public struct Unimplemented: PayloadType, Codable {
    public static func create(from data: Data) -> Unimplemented? {
        SwiftHooks.logger.warning("Trying to listen for an unimplemented event.")
        return nil
    }
}
