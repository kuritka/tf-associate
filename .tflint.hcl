# .tflint.hcl
# Reference: https://github.com/terraform-linters/tflint
# On local to initialize a configuration file for TFLint in your Terraform project: tflint --init
plugin "aws" {
  enabled = true
  version = "0.26.0"
  source  = "github.com/terraform-linters/tflint-ruleset-aws"
}
plugin "terraform" {
  enabled = true
  version = "0.4.0"
  source  = "github.com/terraform-linters/tflint-ruleset-terraform"
}
