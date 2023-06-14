resource "kubernetes_secret_v1" "ghcr" {
  metadata {
    name = "ghcr"
    annotations = {
      "kubernetes.io/service-account.name" = "default"
    }
  }

  type = "kubernetes.io/dockerconfigjson"

  data = {
    ".dockerconfigjson" = jsonencode({
      auths = {
        "ghcr.io" = {
          "username" = var.github_ghcr_owner
          "password" = var.default_github_pat
        }
      }
    })
  }

  depends_on = [time_sleep.wait_linode_grace_period]
}
