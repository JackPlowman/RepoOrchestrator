resource "github_repository" "source_scan" {
  #checkov:skip=CKV_GIT_1
  #checkov:skip=CKV2_GIT_1
  name         = "source_scan"
  description  = "A tool to count technologies and frameworks used in my repositories"
  visibility   = "public"
  homepage_url = "https://jackplowman.github.io/source_scan/"

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

resource "github_repository_dependabot_security_updates" "source_scan" {
  repository = github_repository.source_scan.name
  enabled    = true
}

module "source_scan_default_branch_protection" {
  source = "../modules/default-branch-protection"

  repository_name = github_repository.source_scan.name
  required_status_checks = [
    "Check Code Quality",
    "Check GitHub Actions with zizmor",
    "Check Justfile Format",
    "Check Markdown links",
    "Check Pull Request Title",
    "CodeQL Analysis (actions)",
    "CodeQL Analysis (python)",
    "Dependency Review",
    "Label Pull Request",
    "Run CodeLimit",
    "Run Python Code Checks",
    "Run Unit Tests",
  ]
  required_code_scanning_tools = ["CodeQL", "SonarCloud", "Ruff", "zizmor"]

  depends_on = [github_repository.source_scan]
}

