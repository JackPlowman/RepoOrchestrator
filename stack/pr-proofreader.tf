resource "github_repository" "pr-proofreader" {
  #checkov:skip=CKV_GIT_1
  #checkov:skip=CKV2_GIT_1
  name        = "pr-proofreader"
  description = "A Chrome extension to Spell Check Pull Requests"
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

resource "github_repository_dependabot_security_updates" "pr-proofreader" {
  repository = github_repository.pr-proofreader.name
  enabled    = true
}

module "pr-proofreader_default_branch_protection" {
  source = "../modules/default-branch-protection"

  repository_name = github_repository.pr-proofreader.name
  required_status_checks = [
    "Check Code Quality",
    "Check GitHub Actions with zizmor",
    "Check JavaScript Code",
    "Check Justfile Format",
    "Check Markdown links",
    "Check Pull Request Title",
    "CodeQL Analysis (actions)",
    "CodeQL Analysis (javascript)",
    "Dependency Review",
    "Label Pull Request",
    "Run CodeLimit",
  ]
  required_code_scanning_tools = ["CodeQL", "ESLint", "zizmor"]

  depends_on = [github_repository.pr-proofreader]
}
