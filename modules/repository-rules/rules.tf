resource "github_repository_ruleset" "default_ruleset" {
  name       = "Protect the default branch"
  repository = var.repository_name
  target     = "branch"
  enforcement = "active"

  conditions {
    ref_name {
      include = ["~DEFAULT_BRANCH"]
      exclude = []
    }
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

      dynamic required_check {
        for_each = var.required_status_checks
        content {
          context        = required_check.value
          integration_id = 15368
        }
      }
    }

    required_code_scanning {
      required_code_scanning_tool {
        tool                      = "zizmor"
        alerts_threshold          = "all"
        security_alerts_threshold = "critical"
      }
    }
  }
}
