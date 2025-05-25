resource "github_repository" "screenshot_mailinator_email" {
  #checkov:skip=CKV_GIT_1
  #checkov:skip=CKV2_GIT_1
  name        = "screenshot_mailinator_email"
  description = "A Python script to screenshot an entire email from Mailinator"
  visibility  = "public"

  # Repository Features
  has_issues = true

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

resource "github_repository_dependabot_security_updates" "screenshot_mailinator_email" {
  repository = github_repository.screenshot_mailinator_email.name
  enabled    = true
}

module "screenshot_mailinator_email_default_branch_protection" {
  source = "../modules/default-branch-protection"

  repository_name = github_repository.screenshot_mailinator_email.name
  required_status_checks = [
    "Check Code Quality",
    "CodeQL Analysis (actions) / Analyse code",
    "CodeQL Analysis (python) / Analyse code",
    "Common Code Checks / Check GitHub Actions with zizmor",
    "Common Code Checks / Check Justfile Format",
    "Common Code Checks / Check Markdown links",
    "Common Code Checks / Lefthook Validate",
    "Common Pull Request Tasks / Dependency Review",
    "Common Pull Request Tasks / Label Pull Request",
    "Run CodeLimit",
    "Run Python Code Checks",
    "Run Unit Tests",
  ]
  required_code_scanning_tools = ["CodeQL", "SonarCloud", "Ruff", "zizmor"]

  depends_on = [github_repository.screenshot_mailinator_email]
}
