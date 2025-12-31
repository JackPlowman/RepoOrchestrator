terraform {
  required_version = "1.11.1"
  required_providers {
    github = {
      source  = "integrations/github"
      version = "6.7.5"
    }
  }
  backend "local" {
    path = "../../RepoOrchestratorState/terraform.tfstate"
  }
}

provider "github" {
  token = var.GITHUB_TOKEN
}
