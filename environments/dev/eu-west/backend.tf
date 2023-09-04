terraform {
  backend "kubernetes" {
    secret_suffix  = "state"
    config_path    = "~/.kube/config"
    namespace      = "backend-state-west"
    config_context = "k3d-backend"
  }
}
