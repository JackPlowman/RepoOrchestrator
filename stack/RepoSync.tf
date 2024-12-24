resource "github_repository" "RepoSync" {
  #checkov:skip=CKV_GIT_1
  #checkov:skip=CKV2_GIT_1
  name        = "RepoSync"
  description = "A project to store all scripts used to sync repositories"
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
  has_downloads               = false
  vulnerability_alerts        = true
  web_commit_signoff_required = true
}

module "RepoSync_default_branch_protection" {
  source = "../modules/default-branch-protection"

  repository_name = github_repository.RepoSync.name
  required_status_checks = [
    "Check Code Quality",
    "Check GitHub Actions with zizmor",
    "Label Pull Request",
  ]
  required_code_scanning_tools = ["zizmor"]

  depends_on = [github_repository.RepoSync]
}
