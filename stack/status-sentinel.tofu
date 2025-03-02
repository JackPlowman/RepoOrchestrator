resource "github_repository" "status-sentinel" {
  #checkov:skip=CKV_GIT_1
  #checkov:skip=CKV2_GIT_1
  name         = "status-sentinel"
  description  = "A tool to monitor the status of project websites"
  visibility   = "public"
  homepage_url = "https://jackplowman.github.io/status-sentinel/"

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

resource "github_repository_dependabot_security_updates" "status-sentinel" {
  repository = github_repository.status-sentinel.name
  enabled    = true
}

module "status-sentinel_default_branch_protection" {
  source = "../modules/default-branch-protection"

  repository_name = github_repository.status-sentinel.name
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
    "Run CodeLimit",
    "Run Python Code Checks",
  ]
  required_code_scanning_tools = ["CodeQL", "zizmor"]

  depends_on = [github_repository.status-sentinel]
}
