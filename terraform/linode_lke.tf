resource "linode_lke_cluster" "main-lke-cluster" {
  label       = "main-lke-cluster"
  k8s_version = "1.26"
  region      = var.linode_region

  pool {
    type  = "g6-standard-4"
    count = 1

    autoscaler {
      min = 1
      max = 3
    }
  }
}

resource "time_sleep" "wait_linode_grace_period" {
  depends_on = [linode_lke_cluster.main-lke-cluster]

  create_duration = "600s"
}
