output "id" {
  value = kubernetes_namespace.workspace.id
}


output "cms" {
  value = kubernetes_config_map.cm.*.metadata.0.name
}