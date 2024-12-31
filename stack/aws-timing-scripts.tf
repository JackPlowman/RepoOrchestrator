resource "github_repository" "aws-timing-scripts" {
  #checkov:skip=CKV_GIT_1
  #checkov:skip=CKV2_GIT_1
  name        = "aws-timing-scripts"
  description = ""
  visibility  = "public"

  # Pull Request settings
  # allow_auto_merge            = true # Disabled for now as repository is private
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

module "aws-timing-scripts_default_branch_protection" {
  source = "../modules/default-branch-protection"

  repository_name = github_repository.aws-timing-scripts.name
  required_status_checks = [
    "Check Code Quality",
    "Check GitHub Actions with zizmor",
    "Check Markdown links",
    "CodeQL Analysis",
    "Dependency Review",
    "Label Pull Request",
    "Run CodeLimit",
    "Upload Ruff Analysis Results",
  ]
  required_code_scanning_tools = ["zizmor", "CodeQL", "Ruff"]

  depends_on = [github_repository.aws-timing-scripts]
}
