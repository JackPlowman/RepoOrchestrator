# ------------------------------------------------------------------------------
# Tofu
# ------------------------------------------------------------------------------

export tofu_parallelism := "30"

# Initialize the tofu stack
tofu-init:
    cd stack && tofu init

# Plan the tofu stack
tofu-plan:
    cd stack && tofu plan -parallelism ${tofu_parallelism}

# Apply the tofu stack
tofu-apply:
    cd stack && tofu apply -parallelism ${tofu_parallelism}

# Format the tofu code
tofu-fmt:
    tofu fmt -recursive

# Check the tofu code format
tofu-fmt-check:
    tofu fmt -recursive -check

# Validate the tofu stack
tofu-validate:
    cd stack && tofu validate

# ------------------------------------------------------------------------------
# Checkov
# ------------------------------------------------------------------------------

checkov-scan:
    checkov -d . --output cli --output-file-path console --framework terraform

# ------------------------------------------------------------------------------
# Prettier
# ------------------------------------------------------------------------------

# Check all files with prettier
prettier-check:
    prettier . --check

# Format all files with prettier
prettier-format:
    prettier . --check --write

# ------------------------------------------------------------------------------
# Justfile
# ------------------------------------------------------------------------------

# Format Justfile
format:
    just --fmt --unstable

# Check Justfile formatting
format-check:
    just --fmt --check --unstable

# ------------------------------------------------------------------------------
# Gitleaks
# ------------------------------------------------------------------------------

# Run gitleaks detection
gitleaks-detect:
    gitleaks detect --source .

# ------------------------------------------------------------------------------
# Lefthook
# ------------------------------------------------------------------------------

# Validate lefthook config
lefthook-validate:
    lefthook validate

# ------------------------------------------------------------------------------
# Zizmor
# ------------------------------------------------------------------------------

# Run zizmor checking
zizmor-check:
    uvx zizmor . --persona=auditor

# ------------------------------------------------------------------------------
# Actionlint
# ------------------------------------------------------------------------------

# Run actionlint checks
actionlint-check:
    actionlint

# ------------------------------------------------------------------------------
# Pinact
# ------------------------------------------------------------------------------

# Run pinact
pinact-run:
    pinact run

# Run pinact checking
pinact-check:
    pinact run --verify --check

# Run pinact update
pinact-update:
    pinact run --update

# ------------------------------------------------------------------------------
# EditorConfig
# ------------------------------------------------------------------------------

# Check files format with EditorConfig
editorconfig-check:
    editorconfig-checker

# ------------------------------------------------------------------------------
# Git Hooks
# ------------------------------------------------------------------------------

# Install pre commit hook to run on all commits
install-git-hooks:
    lefthook install -f
