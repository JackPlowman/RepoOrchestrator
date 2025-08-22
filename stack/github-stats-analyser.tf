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

resource "github_repository_dependabot_security_updates" "github-stats-analyser" {
  repository = github_repository.github-stats-analyser.name
  enabled    = true
}

module "github-stats-analyser_default_branch_protection" {
  source = "../modules/default-branch-protection"

  repository_name = github_repository.github-stats-analyser.name
  required_status_checks = concat(
    [
      "Build Docker Image",
      "Check Pull Request Title",
      "CodeQL Analysis (actions) / Analyse code",
      "CodeQL Analysis (python) / Analyse code",
      "CodeQL Analysis (go) / Analyse code",
      "Run Local Action",
      "Run Python Dead Code Checks",
      "Run Python Format Checks",
      "Run Python Lint Checks",
      "Run Python Lockfile Check",
      "Run Python Type Checks",
      "Run Unit Tests",
      "Test GitHub Summary",
      "Validate Schema",
    ],
    local.common_required_status_checks
  )
  required_code_scanning_tools = concat(local.common_code_scanning_tools, ["Ruff", "SonarCloud"])

  depends_on = [github_repository.github-stats-analyser]
}
