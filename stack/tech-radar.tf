resource "github_repository" "tech-radar" {
  #checkov:skip=CKV_GIT_1
  #checkov:skip=CKV2_GIT_1
  name         = "tech-radar"
  description  = "My Tech Radar"
  visibility   = "public"
  homepage_url = "https://jackplowman.github.io/tech-radar/"

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

resource "github_repository_dependabot_security_updates" "tech-radar" {
  repository = github_repository.tech-radar.name
  enabled    = true
}

module "tech-radar_default_branch_protection" {
  source = "../modules/default-branch-protection"

  repository_name = github_repository.tech-radar.name
  required_status_checks = [
    "Check Code Quality",
    "CodeQL Analysis (actions) / Analyse code",
    "Common Code Checks / Check GitHub Actions with Actionlint",
    "Common Code Checks / Check GitHub Actions with zizmor",
    "Common Code Checks / Check Justfile Format",
    "Common Code Checks / Check Markdown links",
    "Common Code Checks / Lefthook Validate",
    "Common Code Checks / Pinact Check",
    "Run Python Tests Format Checks",
    "Run Python Tests Lint Checks",
    "Run Python Tests Lockfile Check",
    "Run Python Tests Type Checks",
    "SonarCloud Scan",
  ]
  required_code_scanning_tools = ["SonarCloud", "zizmor", "CodeQL", "Ruff"]

  depends_on = [github_repository.tech-radar]
}
