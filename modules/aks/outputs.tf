output "cluster_id" {
  description = "The ID of the AKS cluster."
  value       = azurerm_kubernetes_cluster.k8s.id
}

output "cluster_name" {
  description = "The name of the AKS cluster."
  value       = var.cluster_name
}

output "principal_id" {
  value = azurerm_kubernetes_cluster.k8s.identity[0].principal_id
}
