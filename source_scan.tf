resource "github_repository" "source_scan" {
  #checkov:skip=CKV_GIT_1
  #checkov:skip=CKV2_GIT_1
  name         = "source_scan"
  description  = ""
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
