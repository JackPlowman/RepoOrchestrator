terraform {
  required_version = ">= 1.8.7"
  required_providers {
    github = {
      source  = "integrations/github"
      version = "6.4.0"
    }
  }
}
