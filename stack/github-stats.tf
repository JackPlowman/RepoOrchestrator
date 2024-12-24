resource "github_repository" "github-stats" {
  #checkov:skip=CKV_GIT_1
  #checkov:skip=CKV2_GIT_1
  name         = "github-stats"
  description  = ""
  visibility   = "public"
  homepage_url = "https://jackplowman.github.io/github-stats/"

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
  web_commit_signoff_required = true

  # GitHub Pages settings
  pages {
    build_type = "workflow"
    source {
      branch = "main"
      path   = "/"
    }
  }
}

module "github-stats_default_branch_protection" {
  source = "../modules/default-branch-protection"

  repository_name = github_repository.github-stats.name
  required_status_checks = [
    "Check Code Quality",
    "Check GitHub Actions with zizmor",
    "Check Markdown links",
    "Check Pull Request Title",
    "Check Tests Code Format and Quality",
    "Check TypeScript Code Format and Quality",
    "CodeQL Analysis (javascript)",
    "CodeQL Analysis (python)",
    "Dependency Review",
    "Docker Build Test",
    "Label Pull Request",
    "Run CodeLimit",
    "Test GitHub Summary",
    "Test TypeScript Code",
    "Upload ESLint Analysis Results",
    "Upload Ruff Analysis Results",
    "Validate Schema",
  ]
  required_code_scanning_tools = ["zizmor", "CodeQL", "Ruff", "ESLint"]

  depends_on = [github_repository.github-stats]
}
