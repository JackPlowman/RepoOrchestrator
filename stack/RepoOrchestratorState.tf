resource "github_repository" "RepoOrchestratorState" {
  #checkov:skip=CKV2_GIT_1
  name        = "RepoOrchestratorState"
  description = "A state repository for the RepoOrchestrator Infrastructure as Code"
  visibility  = "private"

  # Pull Request settings
  allow_merge_commit          = false
  allow_rebase_merge          = false
  allow_update_branch         = true
  delete_branch_on_merge      = true
  squash_merge_commit_message = "PR_BODY"
  squash_merge_commit_title   = "PR_TITLE"

  # Other settings
  vulnerability_alerts        = true
  web_commit_signoff_required = true
}

resource "github_repository_dependabot_security_updates" "RepoOrchestratorState" {
  repository = github_repository.RepoOrchestratorState.name
  enabled    = true
}
