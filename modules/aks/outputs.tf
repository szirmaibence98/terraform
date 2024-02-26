output "cluster_id" {
  description = "The ID of the AKS cluster."
  value       = azurerm_kubernetes_cluster.k8s.id
}

output "cluster_name" {
  value = azurerm_kubernetes_cluster.k8s.cluster_name
}
