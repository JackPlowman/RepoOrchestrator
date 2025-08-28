resource "github_repository" "SlocCount" {
  #checkov:skip=CKV_GIT_1
  #checkov:skip=CKV2_GIT_1
  name         = "SlocCount"
  description  = "A repository to count the lines of code in a project"
  visibility   = "public"
  homepage_url = "https://jackplowman.github.io/SlocCount/"

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

  # GitHub Pages settings
  pages {
    build_type = "workflow"
    source {
      branch = "main"
      path   = "/"
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
  required_status_checks = concat(
    [
      "CodeQL Analysis (actions) / Analyse code",
      "CodeQL Analysis (python) / Analyse code",
      "CodeQL Analysis (typescript) / Analyse code",
      "Run Python Scanner Dead Code Checks",
      "Run Python Scanner Format Checks",
      "Run Python Scanner Lint Checks",
      "Run Python Scanner Lockfile Check",
      "Run Python Scanner Type Checks",
      "Run Python Tests Format Checks",
      "Run Python Tests Lint Checks",
      "Run Python Tests Lockfile Check",
      "Run Python Tests Type Checks",
      "Run Unit Tests",
    ],
    local.common_required_status_checks
  )
  required_code_scanning_tools = concat(local.common_code_scanning_tools, ["Ruff", "SonarCloud"])

  depends_on = [github_repository.SlocCount]
}
