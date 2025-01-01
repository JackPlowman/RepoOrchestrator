resource "github_repository" "github-stats-analyser" {
  #checkov:skip=CKV_GIT_1
  #checkov:skip=CKV2_GIT_1
  name        = "github-stats-analyser"
  description = "GitHub action to analyse a user's GitHub repositories"
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

module "github-stats-analyser_default_branch_protection" {
  source = "../modules/default-branch-protection"

  repository_name = github_repository.github-stats-analyser.name
  required_status_checks = [
    "Build Docker Image",
    "Check Code Quality",
    "Check GitHub Actions with zizmor",
    "Check Markdown links",
    "Check Pull Request Title",
    "CodeQL Analysis",
    "Dependency Review",
    "Label Pull Request",
    "Run CodeLimit",
    "Run Local Action",
    "Run Python Code Checks",
    "Run Unit Tests",
    "Test GitHub Summary",
    "Validate Schema",
  ]
  required_code_scanning_tools = ["zizmor", "CodeQL", "Ruff", "SonarCloud"]

  depends_on = [github_repository.github-stats-analyser]
}
