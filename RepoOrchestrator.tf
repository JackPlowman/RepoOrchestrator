resource "github_repository" "RepoOrchestrator" {
  #checkov:skip=CKV_GIT_1
  #checkov:skip=CKV2_GIT_1
  name        = "RepoOrchestrator"
  description = "Keep all my repositories in sync."
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
  has_downloads        = false
  vulnerability_alerts = true
}

resource "github_repository_ruleset" "RepoOrchestrator_default_ruleset" {
  name        = "Protect the default branch"
  repository  = github_repository.RepoOrchestrator.name
  target      = "branch"
  enforcement = "active"

  conditions {
    ref_name {
      include = ["~DEFAULT_BRANCH"]
      exclude = []
    }
  }

  bypass_actors {
    actor_id    = 5
    actor_type  = "RepositoryRole"
    bypass_mode = "pull_request"
  }

  rules {
    creation                = false
    update                  = false
    deletion                = true
    non_fast_forward        = true
    required_linear_history = true
    required_signatures     = true
    pull_request {
      dismiss_stale_reviews_on_push     = true
      require_code_owner_review         = false
      require_last_push_approval        = false
      required_approving_review_count   = 0
      required_review_thread_resolution = true
    }

    required_status_checks {
      strict_required_status_checks_policy = true

      required_check {
        context        = "Check Code Quality"
        integration_id = 15368
      }
      required_check {
        context        = "Check GitHub Actions with zizmor"
        integration_id = 15368
      }
      required_check {
        context        = "Check Markdown links"
        integration_id = 15368
      }
      required_check {
        context        = "Label Pull Request"
        integration_id = 15368
      }
    }

    required_code_scanning {
      required_code_scanning_tool {
        tool = "zizmor"
        alerts_threshold = "all"
        security_alerts_threshold = "critical"
      }
    }
  }
}
