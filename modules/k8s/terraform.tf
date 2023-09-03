terraform {
  required_version = ">= 1.5.6, < 2.0.0"

  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 1.11.3"
    }
  }
}

variable "cluster_ca_certificate" {
  type        = string
  description = "PEM encoded CA certificate for the cluster (REQUIRED)"
}

variable "client_key" {
  type        = string
  description = "PEM encoded client key for the cluster (REQUIRED)"
}

variable "client_certificate" {
  type        = string
  description = "PEM encoded client certificate for the cluster (REQUIRED)"
}

provider "kubernetes" {
  #  terraform plan runs in terraform cloud and doesn't have access to the kubeconfig file
  #  terraform cloud can set terraform variables which can be used to set the kubernetes provider
  #  we can't use the environment varibles, because they are can't set PEM format for the certificate-authority-data etc.
  #  config_path    = "~/.kube/config"
  #
  #  config_context         = var.context
  # https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs#argument-reference
  client_certificate     = var.client_certificate
  client_key             = var.client_key
  cluster_ca_certificate = var.cluster_ca_certificate
}
