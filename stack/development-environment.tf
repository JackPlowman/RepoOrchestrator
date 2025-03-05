resource "github_repository" "development-environment" {
  #checkov:skip=CKV_GIT_1
  #checkov:skip=CKV2_GIT_1
  name        = "development-environment"
  description = "My dotfiles for MacOS"
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

  # Security settings
  security_and_analysis {
    secret_scanning {
      status = "enabled"
    }
    secret_scanning_push_protection {
      status = "enabled"
    }
  }
}

resource "github_repository_dependabot_security_updates" "development-environment" {
  repository = github_repository.development-environment.name
  enabled    = true
}

module "development-environment_default_branch_protection" {
  source = "../modules/default-branch-protection"

  repository_name = github_repository.development-environment.name
  required_status_checks = [
    "Check Code Quality",
    "Check GitHub Actions with zizmor",
    "Check Justfile Format",
    "Check Markdown links",
    "CodeQL Analysis",
    "Dependency Review",
    "Label Pull Request",
    "Lefthook Validate",
  ]
  required_code_scanning_tools = ["zizmor", "CodeQL"]

  depends_on = [github_repository.development-environment]
}
