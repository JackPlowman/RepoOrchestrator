locals {
  common_required_status_checks = [
    "Common Code Checks / Check Code Formatting with Prettier",
    "Common Code Checks / Check File Formats with EditorConfig Checker",
    "Common Code Checks / Check GitHub Actions with Actionlint",
    "Common Code Checks / Check GitHub Actions with zizmor",
    "Common Code Checks / Check Justfile Format",
    "Common Code Checks / Check Markdown Files with Markdownlint",
    "Common Code Checks / Check Markdown links",
    "Common Code Checks / Check Vulnerabilities, Secrets, Misconfigurations, and Licenses with Trivy",
    "Common Code Checks / Check YAML Files with Yamllint",
    "Common Code Checks / Check for Secrets with Gitleaks",
    "Common Code Checks / Check for Secrets with TruffleHog",
    "Common Code Checks / Check for Vulnerabilities with Grype",
    "Common Code Checks / Lefthook Validate",
    "Common Code Checks / Pinact Check",
    "Common Pull Request Tasks / Dependency Review",
    "Common Pull Request Tasks / Label Pull Request",
  ]
  common_code_scanning_tools = ["zizmor", "CodeQL", "Grype"]
}
