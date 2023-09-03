terraform {
  required_version = ">= 1.5.6, < 2.0.0"

  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 1.11.3"
    }
  }
}

provider "kubernetes" {
  #  terraform plan runs in terraform cloud and doesn't have access to the kubeconfig file
  #  config_path    = "~/.kube/config"
  config_context = var.context
}
