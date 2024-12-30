resource "github_repository" "project-status-checker" {
  #checkov:skip=CKV_GIT_1
  #checkov:skip=CKV2_GIT_1
  name        = "project-status-checker"
  description = "GitHub Action to Check Project Statuses"
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
}

module "project-status-checker_default_branch_protection" {
  source = "../modules/default-branch-protection"

  repository_name = github_repository.project-status-checker.name
  required_status_checks = [
    "Build Docker Image and Run",
    "Check Code Quality",
    "Check GitHub Actions with zizmor",
    "Check Justfile Format",
    "Check Markdown links",
    "Check Pull Request Title",
    "Check Pull Request Title",
    "Check Python Code Format and Quality",
    "CodeQL Analysis",
    "Dependency Review",
    "Label Pull Request",
    "Run CodeLimit",
    "Run Local Project Status Checker Action",
    "Run Unit Tests",
    "Test GitHub Summary",
    "Upload Python Ruff Scanner Results",
  ]
  required_code_scanning_tools = ["CodeQL", "Ruff", "zizmor"]

  depends_on = [github_repository.project-status-checker]
}
