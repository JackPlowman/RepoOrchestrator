# ------------------------------------------------------------------------------
# Tofu
# ------------------------------------------------------------------------------

# Initialize the tofu stack
tofu-init:
    cd stack && tofu init

# Plan the tofu stack
tofu-plan:
    cd stack && tofu plan

# Apply the tofu stack
tofu-apply:
    cd stack && tofu apply

# Format the tofu code
tofu-fmt:
    tofu fmt -recursive

# Check the tofu code format
tofu-fmt-check:
    tofu fmt -recursive -check

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
    zizmor .

# ------------------------------------------------------------------------------
# Pinact
# ------------------------------------------------------------------------------

# Run pinact
pinact-run:
    pinact run -c .github/other-configurations/pinact.yml

# Run pinact checking
pinact-check:
    pinact run -c .github/other-configurations/pinact.yml --verify --check

# Run pinact update
pinact-update:
    pinact run -c .github/other-configurations/pinact.yml --update

# ------------------------------------------------------------------------------
# Git Hooks
# ------------------------------------------------------------------------------

# Install pre commit hook to run on all commits
install-git-hooks:
    lefthook install -f
