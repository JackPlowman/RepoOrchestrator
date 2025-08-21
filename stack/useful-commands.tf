resource "github_repository" "useful-commands" {
  #checkov:skip=CKV_GIT_1
  #checkov:skip=CKV2_GIT_1
  name        = "useful-commands"
  description = "A collection of my useful commands"
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
}

module "useful-commands_default_branch_protection" {
  source = "../modules/default-branch-protection"

  repository_name = github_repository.useful-commands.name
  required_status_checks = [
    "Common Code Checks / Check File Formats with EditorConfig Checker",
    "Check Code Quality",
    "CodeQL Analysis (actions) / Analyse code",
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
  ]
  required_code_scanning_tools = local.common_code_scanning_tools

  depends_on = [github_repository.useful-commands]
}

resource "github_repository_dependabot_security_updates" "useful-commands" {
  repository = github_repository.useful-commands.name
  enabled    = true
}
