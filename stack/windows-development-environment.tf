resource "github_repository" "windows-development-environment" {
  #checkov:skip=CKV_GIT_1
  #checkov:skip=CKV2_GIT_1
  name        = "windows-development-environment"
  description = ""
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

  template {
    include_all_branches = false
    owner                = "JackPlowman"
    repository           = "repository-template"
  }
}

resource "github_repository_dependabot_security_updates" "windows-development-environment" {
  repository = github_repository.windows-development-environment.name
  enabled    = true
}

module "windows-development-environment_default_branch_protection" {
  source = "../modules/default-branch-protection"

  repository_name = github_repository.windows-development-environment.name
  required_status_checks = [
    "Check Code Quality",
    "CodeQL Analysis",
    "Common Code Checks / Check GitHub Actions with zizmor",
    "Common Code Checks / Check Justfile Format",
    "Common Code Checks / Check Markdown links",
    "Common Code Checks / Lefthook Validate",
    "Common Pull Request Tasks / Dependency Review",
    "Common Pull Request Tasks / Label Pull Request",
  ]
  required_code_scanning_tools = ["CodeQL", "zizmor"]

  depends_on = [github_repository.windows-development-environment]
}
