output "main-lke-cluster-kubeconfig" {
  value     = yamldecode(base64decode(linode_lke_cluster.main-lke-cluster.kubeconfig))
  sensitive = true
}
