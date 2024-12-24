resource "github_repository" "aws-timing-scripts" {
  #checkov:skip=CKV2_GIT_1
  name        = "aws-timing-scripts"
  description = ""
  visibility  = "private"

  # Pull Request settings
  # allow_auto_merge            = true # Disabled for now as repository is private
  allow_merge_commit          = false
  allow_rebase_merge          = false
  allow_update_branch         = true
  delete_branch_on_merge      = true
  squash_merge_commit_message = "PR_BODY"
  squash_merge_commit_title   = "PR_TITLE"

  # Other settings
  has_downloads        = false
  vulnerability_alerts = true
  web_commit_signoff_required = true
}
