output "ids" {
  value = [kubernetes_namespace.one.id, kubernetes_namespace.two.id, kubernetes_namespace.three.id]
}