resource "github_repository" "development-ideas" {
  #checkov:skip=CKV_GIT_1
  #checkov:skip=CKV2_GIT_1
  name         = "development-ideas"
  description  = "A place to list my project ideas"
  visibility   = "public"
  homepage_url = "https://jackplowman.github.io/development-ideas/"

  # Pull Request settings
  allow_auto_merge            = true
  allow_merge_commit          = false
  allow_rebase_merge          = false
  allow_update_branch         = true
  delete_branch_on_merge      = true
  squash_merge_commit_message = "PR_BODY"
  squash_merge_commit_title   = "PR_TITLE"

  # Other settings
  has_downloads        = false
  vulnerability_alerts = true

  # GitHub Pages settings
  pages {
    build_type = "workflow"
    source {
      branch = "main"
      path   = "/"
    }
  }
}
