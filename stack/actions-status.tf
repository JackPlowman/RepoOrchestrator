resource "github_repository" "actions-status" {
  #checkov:skip=CKV_GIT_1
  #checkov:skip=CKV2_GIT_1
  name        = "actions-status"
  description = ""
  visibility  = "public"

  # Repository Features
  has_issues   = true
  has_projects = true

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

  template {
    include_all_branches = false
    owner                = "JackPlowman"
    repository           = "repository-template"
  }
}


resource "github_repository_dependabot_security_updates" "actions-status" {
  repository = github_repository.actions-status.name
  enabled    = true
}

module "actions-status_default_branch_protection" {
  source = "../modules/default-branch-protection"

  repository_name = github_repository.actions-status.name
  required_status_checks = [
    "Check Code Quality",
    "Check Pull Request Title",
    "CodeQL Analysis (actions) / Analyse code",
    "CodeQL Analysis (typescript) / Analyse code",
    "Common Code Checks / Check GitHub Actions with Actionlint",
    "Common Code Checks / Check GitHub Actions with zizmor",
    "Common Code Checks / Check Justfile Format",
    "Common Code Checks / Check Markdown links",
    "Common Code Checks / Check for Secrets with Gitleaks",
    "Common Code Checks / Check for Secrets with TruffleHog",
    "Common Code Checks / Check for Vulnerabilities with Grype",
    "Common Code Checks / Lefthook Validate",
    "Common Code Checks / Pinact Check",
    "Common Pull Request Tasks / Dependency Review",
    "Common Pull Request Tasks / Label Pull Request",
  ]
  required_code_scanning_tools = ["zizmor", "CodeQL"]

  depends_on = [github_repository.actions-status]
}
