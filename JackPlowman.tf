#checkov:skip=CKV_GIT_1
#checkov:skip=CKV_GIT_2
resource "github_repository" "JackPlowman" {
  name        = "JackPlowman"
  description = "My Profile"
  visibility  = "public"

  allow_auto_merge       = true
  allow_merge_commit     = false
  allow_rebase_merge     = false
  allow_update_branch    = true
  delete_branch_on_merge = true

  squash_merge_commit_message = "PR_BODY"
  squash_merge_commit_title   = "PR_TITLE"
  vulnerability_alerts        = true
}
