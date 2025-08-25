resource "github_repository" "project-links" {
  #checkov:skip=CKV_GIT_1
  #checkov:skip=CKV2_GIT_1
  name         = "project-links"
  description  = "A collection of links to my projects"
  visibility   = "public"
  homepage_url = "https://jackplowman.github.io/project-links/"

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

resource "github_repository_dependabot_security_updates" "project-links" {
  repository = github_repository.project-links.name
  enabled    = true
}

module "project-links_default_branch_protection" {
  source = "../modules/default-branch-protection"

  repository_name = github_repository.project-links.name
  required_status_checks = concat(
    [
      "Check Code Quality",
      "CodeQL Analysis (actions) / Analyse code",
      "CodeQL Analysis (python) / Analyse code",
      "CodeQL Analysis (typescript) / Analyse code",
      "Run Python Tests Format Checks",
      "Run Python Tests Lint Checks",
      "Run Python Tests Lockfile Check",
      "Run Python Tests Type Checks",
      "Run TypeScript Code Checks",
    ],
    local.common_required_status_checks
  )
  required_code_scanning_tools = concat(local.common_code_scanning_tools, ["Ruff", "ESLint"])

  depends_on = [github_repository.project-links]
}
