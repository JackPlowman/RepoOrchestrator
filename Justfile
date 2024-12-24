# ------------------------------------------------------------------------------
# Tofu
# ------------------------------------------------------------------------------

# Initialize the tofu stack
tofu-init:
    cd stack && tofu init

# Apply the tofu stack
tofu-apply:
    cd stack && tofu apply

tofu-fmt:
    cd stack && tofu fmt
    cd modules/default-branch-protection && tofu fmt


# ------------------------------------------------------------------------------
# Prettier - File Formatting
# ------------------------------------------------------------------------------

# Check for prettier issues
prettier-check:
    prettier . --check

# Fix prettier issues
prettier-format:
    prettier . --check --write

# ------------------------------------------------------------------------------
# Justfile
# ------------------------------------------------------------------------------

# Format the Just code
format:
    just --fmt --unstable

# Check for Just format issues
format-check:
    just --fmt --check --unstable

