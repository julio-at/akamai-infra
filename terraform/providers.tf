provider "linode" {
  token = var.linode_api_token
}

provider "kubernetes" {
  host                   = local.lke_kubeconfig.clusters.0.cluster.server
  cluster_ca_certificate = base64decode(local.lke_kubeconfig.clusters.0.cluster.certificate-authority-data)

  token = local.lke_kubeconfig.users.0.user.token
}

provider "helm" {
  kubernetes {
    host                   = local.lke_kubeconfig.clusters.0.cluster.server
    cluster_ca_certificate = base64decode(local.lke_kubeconfig.clusters.0.cluster.certificate-authority-data)
    token                  = local.lke_kubeconfig.users.0.user.token
  }
}

provider "kubectl" {
  host                   = local.lke_kubeconfig.clusters.0.cluster.server
  cluster_ca_certificate = base64decode(local.lke_kubeconfig.clusters.0.cluster.certificate-authority-data)
  token                  = local.lke_kubeconfig.users.0.user.token
  load_config_file       = false
}
