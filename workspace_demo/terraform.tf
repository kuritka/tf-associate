terraform {
  required_version = ">= 1.5.6, < 2.0.0"

  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 1.11.3"
    }
  }
  #  backend "kubernetes" {
  #    secret_suffix  = "state"
  #    config_path    = "~/.kube/config"
  #    namespace      = "backend-workspace"
  #    config_context = "k3d-backend"
  #  }
}


provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = var.context
  #  terraform plan runs in terraform cloud and doesn't have access to the kubeconfig file
  #  terraform cloud can set terraform variables which can be used to set the kubernetes provider
  #  we can't use the environment varibles, because they are can't set PEM format for the certificate-authority-data etc.
  # https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs#argument-reference
}
