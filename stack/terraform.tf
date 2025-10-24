terraform {
  required_version = "1.10.6"
  required_providers {
    github = {
      source  = "integrations/github"
      version = "6.7.0"
    }
  }
  backend "local" {
    path = "../../RepoOrchestratorState/terraform.tfstate"
  }
}

provider "github" {
  token = var.GITHUB_TOKEN
}
