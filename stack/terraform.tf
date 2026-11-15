terraform {
  required_version = "1.13.9"
  required_providers {
    github = {
      source  = "integrations/github"
      version = "6.13.0"
    }
  }
  backend "local" {
    path = "../../RepoOrchestratorState/terraform.tfstate"
  }
}

provider "github" {
  token = var.GITHUB_TOKEN
}
