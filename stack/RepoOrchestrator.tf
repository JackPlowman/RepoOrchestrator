resource "github_repository" "RepoOrchestrator" {
  #checkov:skip=CKV_GIT_1
  #checkov:skip=CKV2_GIT_1
  name        = "RepoOrchestrator"
  description = "Keep all my repositories in sync."
  visibility  = "public"

  # Pull Request settings
  allow_auto_merge            = true
  allow_merge_commit          = false
  allow_rebase_merge          = false
  allow_update_branch         = true
  delete_branch_on_merge      = true
  squash_merge_commit_message = "PR_BODY"
  squash_merge_commit_title   = "PR_TITLE"

  # Other settings
  has_downloads        = false
  vulnerability_alerts = true
}

module "RepoOrchestrator_default_branch_protection" {
  source = "../modules/default-branch-protection"

  repository_name = github_repository.RepoOrchestrator.name
  required_status_checks = [
    "Check Code Quality",
    "Check GitHub Actions with zizmor",
    "Check Markdown links",
    "Label Pull Request"
  ]
  required_code_scanning_tools = ["zizmor"]

  depends_on = [github_repository.RepoOrchestrator]
}