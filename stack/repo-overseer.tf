resource "github_repository" "repo-overseer" {
  #checkov:skip=CKV_GIT_1
  #checkov:skip=CKV2_GIT_1
  name        = "repo-overseer"
  description = "A dashboard for reviewing all my repository settings"
  visibility  = "public"
  homepage_url = "https://jackplowman.github.io/repo-overseer"

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

  # GitHub Pages settings
  pages {
    build_type = "workflow"
    source {
      branch = "main"
      path   = "/"
    }
  }

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

module "repo-overseer_default_branch_protection" {
  source = "../modules/default-branch-protection"

  repository_name = github_repository.repo-overseer.name
  required_status_checks = [
    "Check Code Quality",
    "Check GitHub Actions with zizmor",
    "Check Justfile Format",
    "Check Markdown links",
    "Check Pull Request Title",
    "Run TypeScript Code Checks",
    "CodeQL Analysis (actions)",
    "CodeQL Analysis (python)",
    "CodeQL Analysis (typescript)",
    "Dependency Review",
    "Label Pull Request",
    "Run Python Code Checks",
  ]
  required_code_scanning_tools = ["CodeQL", "Ruff", "zizmor"]

  depends_on = [github_repository.repo-overseer]
}
