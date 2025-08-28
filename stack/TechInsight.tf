resource "github_repository" "TechInsight" {
  #checkov:skip=CKV_GIT_1
  #checkov:skip=CKV2_GIT_1
  name        = "TechInsight"
  description = ""
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

  template {
    include_all_branches = false
    owner                = "JackPlowman"
    repository           = "repository-template"
  }
}

resource "github_repository_dependabot_security_updates" "TechInsight" {
  repository = github_repository.TechInsight.name
  enabled    = true
}


module "TechInsight_default_branch_protection" {
  source = "../modules/default-branch-protection"

  repository_name = github_repository.TechInsight.name
  required_status_checks = concat(
    ["CodeQL Analysis (actions) / Analyse code"],
    local.common_required_status_checks
  )
  required_code_scanning_tools = local.common_code_scanning_tools

  depends_on = [github_repository.TechInsight]
}
