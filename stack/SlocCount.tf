resource "github_repository" "SlocCount" {
  #checkov:skip=CKV_GIT_1
  #checkov:skip=CKV2_GIT_1
  name        = "SlocCount"
  description = "A repository to count the lines of code in a project"
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

module "SlocCount_default_branch_protection" {
  source = "../modules/default-branch-protection"

  repository_name = github_repository.SlocCount.name
  required_status_checks = [
    "Check Code Quality",
    "CodeQL Analysis (actions)",
    "CodeQL Analysis (python)",
    "Common Code Checks / Check GitHub Actions with zizmor",
    "Common Code Checks / Check Justfile Format",
    "Common Code Checks / Check Markdown links",
    "Common Code Checks / Lefthook Validate",
    "Common Pull Request Tasks / Dependency Review",
    "Common Pull Request Tasks / Label Pull Request",
    "Run CodeLimit",
    "Run Scanner Python Code Checks",
    "Run Tests Python Code Checks",
    "Run Unit Tests",
  ]
  required_code_scanning_tools = ["zizmor", "CodeQL", "Ruff", "SonarCloud"]

  depends_on = [github_repository.SlocCount]
}
