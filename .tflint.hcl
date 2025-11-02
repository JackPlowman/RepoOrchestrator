# TFLint configuration for the RepoOrchestrator stack
config {
  call_module_type = "all"
  force  = false
  format = "default"
}

rule "terraform_required_providers" {
  enabled = true
}

rule "terraform_required_version" {
  enabled = true
}

rule "terraform_unused_declarations" {
  enabled = true
}
