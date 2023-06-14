data "linode_lke_cluster" "main-lke-cluster" {
  id         = linode_lke_cluster.main-lke-cluster.id
  depends_on = [linode_lke_cluster.main-lke-cluster]
}

locals {
  lke_kubeconfig = yamldecode(base64decode(data.linode_lke_cluster.main-lke-cluster.kubeconfig))
}
