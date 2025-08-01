resource "github_repository" "repository-visualiser" {
  #checkov:skip=CKV_GIT_1
  #checkov:skip=CKV2_GIT_1
  name        = "repository-visualiser"
  description = "A tool to visualise the structure of a GitHub repository"
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

resource "github_repository_dependabot_security_updates" "repository-visualiser" {
  repository = github_repository.repository-visualiser.name
  enabled    = true
}

module "repository-visualiser_default_branch_protection" {
  source = "../modules/default-branch-protection"

  repository_name = github_repository.repository-visualiser.name
  required_status_checks = [
    "Check Code Quality",
    "CodeQL Analysis (actions) / Analyse code",
    "CodeQL Analysis (go) / Analyse code",
    "Common Code Checks / Check File Formats with EditorConfig Checker",
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
    "Repository Visualiser",
  ]
  required_code_scanning_tools = ["zizmor", "CodeQL", "Grype"]

  depends_on = [github_repository.repository-template]
}
