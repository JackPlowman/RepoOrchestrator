# RepoOrchestrator AI Playbook

## Big picture

- Infrastructure-as-code repo that drives **JackPlowman**'s GitHub org using OpenTofu 1.10.7.
- Desired state lives in `stack/*.tf`; each file usually maps 1:1 to a managed repository or automation project.
- The `modules/` folder holds reusable Terraform modules; currently `default-branch-protection` centralises branch protection rules and status checks.
- GitHub Actions for this repo depend on pinned commits from `JackPlowman/reusable-workflows`; keep references in `.github/workflows/*.yml` aligned with `stack/reusable-workflows.tf`.

## Repo layout patterns

- `stack/terraform.tf` configures the `integrations/github` provider and stores state at `../../RepoOrchestratorState/terraform.tfstate`; assume this folder already exists when running Tofu.
- `stack/locals.tf` defines shared status checks and scanning tools; most repositories `concat` additional checks on top of these lists.
- Standard stack file structure:
  - `resource "github_repository"` with security settings (`secret_scanning`, `web_commit_signoff_required`, etc.).
  - Optional `template` block pulling from `JackPlowman/repository-template` when new repos should inherit files.
  - `resource "github_repository_dependabot_security_updates"` toggles Dependabot alerts.
  - `module "*_default_branch_protection"` applies `modules/default-branch-protection` with repo-specific check lists.
- `modules/default-branch-protection/rules.tf` dynamically wires required checks (integration ID `15368`) and code-scanning tools; adjust inputs in stack files rather than editing the module.

## Automation & workflows

- `.github/workflows/code-checks.yml` runs reusable common checks plus CodeQL and an inline Checkov scan; keep secrets named `GITHUB_TOKEN` except `clean-caches.yml` which expects `GH_TOKEN`.
- `pull-request-tasks.yml` and `sync-labels.yml` rely on the reusable workflows repo—updating workflow versions requires bumping the pinned commit SHA everywhere.
- `pre-commit-config.yml` mirrors CI by running `just` targets (`prettier-check`, `zizmor-check`, `pinact-check`, etc.) before commits; ensure new tooling has a matching `just` command before adding hooks.

## Working locally

- `Justfile` is the source of truth for commands; key targets:
  - `just tofu-init|plan|apply` (use `tofu_parallelism` env var, default 30).
  - `just tofu-fmt` / `tofu-fmt-check` before commits to satisfy hooks and Checkov.
  - `just checkov-scan` for full IaC security audit when touching Terraform.
- Export `GITHUB_TOKEN` with org-level admin (repo + actions + codespaces) before running Tofu; without it provider calls will fail.
- Run tooling from repo root; hooks assume commands execute there even when Terraform lives under `stack/`.

## Implementation tips

- When creating a new repo definition, copy an existing stack file and update names, description, and required checks; keep the resource, Dependabot, and module trio together.
- Shared lists in `locals.tf` keep status checks consistent—only append bespoke checks in the stack file's `concat([...], local.common_required_status_checks)` section.
- Skip annotations (`#checkov:skip=...`) are intentional to satisfy known GitHub provider limitations—avoid removing unless the upstream issue is solved.
- Pin new external dependencies (GitHub Actions, CLI tools invoked by `just`) to exact versions to match the org security posture.
- Keep documentation for new repos in this stack; Terraform comments or accompanying markdown in `docs/` help future contributors.
