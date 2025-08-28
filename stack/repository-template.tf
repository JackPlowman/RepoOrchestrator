resource "github_repository" "repository-template" {
  #checkov:skip=CKV_GIT_1
  #checkov:skip=CKV2_GIT_1
  name        = "repository-template"
  description = "A template repository for creating new repositories"
  visibility  = "public"

  # Pull Request settings
  allow_auto_merge            = true
  allow_merge_commit          = false
  allow_rebase_merge          = false
  allow_update_branch         = true
  delete_branch_on_merge      = true
  squash_merge_commit_message = "PR_BODY"
  squash_merge_commit_title   = "PR_TITLE"

  # Other settings
  is_template                 = true
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

resource "github_repository_dependabot_security_updates" "repository-template" {
  repository = github_repository.repository-template.name
  enabled    = true
}

module "repository-template_default_branch_protection" {
  source = "../modules/default-branch-protection"

  repository_name = github_repository.repository-template.name
  required_status_checks = concat(
    [
      "CodeQL Analysis (actions) / Analyse code",
    ],
    local.common_required_status_checks
  )
  required_code_scanning_tools = local.common_code_scanning_tools

  depends_on = [github_repository.repository-template]
}
