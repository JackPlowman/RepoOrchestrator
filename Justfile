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

prettier-check:
    prettier . --check

prettier-format:
    prettier . --check --write

# ------------------------------------------------------------------------------
# Justfile
# ------------------------------------------------------------------------------

format:
    just --fmt --unstable

format-check:
    just --fmt --check --unstable

# ------------------------------------------------------------------------------
# gitleaks
# ------------------------------------------------------------------------------

gitleaks-detect:
    gitleaks detect --source . > /dev/null

# ------------------------------------------------------------------------------
# Git Hooks
# ------------------------------------------------------------------------------

# Install pre commit hook to run on all commits
install-git-hooks:
    cp -f githooks/pre-commit .git/hooks/pre-commit
    cp -f githooks/post-commit .git/hooks/post-commit
    chmod ug+x .git/hooks/*
