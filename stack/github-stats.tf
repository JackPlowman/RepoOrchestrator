resource "github_repository" "github-stats" {
  #checkov:skip=CKV_GIT_1
  #checkov:skip=CKV2_GIT_1
  name         = "github-stats"
  description  = "A Website to display my Repository Statistics"
  visibility   = "public"
  homepage_url = "https://jackplowman.github.io/github-stats/"

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

  # GitHub Pages settings
  pages {
    build_type = "workflow"
    source {
      branch = "main"
      path   = "/"
    }
  }
}

resource "github_repository_dependabot_security_updates" "github-stats" {
  repository = github_repository.github-stats.name
  enabled    = true
}

module "github-stats_default_branch_protection" {
  source = "../modules/default-branch-protection"

  repository_name = github_repository.github-stats.name
  required_status_checks = [
    "Check Code Quality",
    "Check GitHub Actions with zizmor",
    "Check Justfile Format",
    "Check Markdown links",
    "Check Pull Request Title",
    "CodeQL Analysis (actions)",
    "CodeQL Analysis (python)",
    "CodeQL Analysis (typescript)",
    "Dependency Review",
    "Label Pull Request",
    "Lefthook Validate",
    "Run CodeLimit",
    "Run Python Code Checks",
    "Run TypeScript Code Checks",
    "Test TypeScript Code",
  ]
  required_code_scanning_tools = ["zizmor", "CodeQL", "Ruff", "ESLint", "SonarCloud"]

  depends_on = [github_repository.github-stats]
}
