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
    "Check Pull Request Title",
    "CodeQL Analysis (actions) / Analyse code",
    "CodeQL Analysis (python) / Analyse code",
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
    "Run Python Dead Code Checks",
    "Run Python Format Checks",
    "Run Python Lint Checks",
    "Run Python Lockfile Check",
    "Run Python Type Checks",
    "Run Unit Tests",
  ]
  required_code_scanning_tools = ["CodeQL", "SonarCloud", "Ruff", "zizmor", "Grype"]

  depends_on = [github_repository.source_scan]
}

