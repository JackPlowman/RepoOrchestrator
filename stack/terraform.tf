terraform {
  required_version = "1.9.1"
  required_providers {
    github = {
      source  = "integrations/github"
      version = "6.6.0"
    }
  }
  backend "local" {
    path = "../../RepoOrchestratorState/terraform.tfstate"
  }
}

provider "github" {
  token = var.GITHUB_TOKEN
}
