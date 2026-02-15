resource "github_repository" "JackPlowman" {
  #checkov:skip=CKV_GIT_1
  #checkov:skip=CKV2_GIT_1
  name        = "JackPlowman"
  description = "My Profile"
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

resource "github_repository_dependabot_security_updates" "JackPlowman" {
  repository = github_repository.JackPlowman.name
  enabled    = true
}
