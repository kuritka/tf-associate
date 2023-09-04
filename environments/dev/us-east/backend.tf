# terraform {
#  cloud {
#    organization = "kuritka-test"
#    workspaces {
#      name = "ta-dev"
#    }
#  }
#}

terraform {
  backend "kubernetes" {
    secret_suffix  = "state"
    config_path    = "~/.kube/config"
    namespace      = "backend-state-east"
    config_context = "k3d-backend"
  }
}
