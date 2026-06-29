terraform {
  required_version = "1.11.2"
  required_providers {
    github = {
      source  = "integrations/github"
      version = "6.12.1"
    }
  }
  backend "local" {
    path = "../../RepoOrchestratorState/terraform.tfstate"
  }
}

provider "github" {
  token = var.GITHUB_TOKEN
}
