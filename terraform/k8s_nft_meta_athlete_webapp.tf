resource "kubernetes_deployment_v1" "nft-meta-athlete-webapp" {
  metadata {
    name = "nft-meta-athlete-webapp"
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "nft-meta-athlete-webapp"
      }
    }

    template {
      metadata {
        labels = {
          app = "nft-meta-athlete-webapp"
        }
      }

      spec {
        container {
          name  = "nft-meta-athlete-webapp"
          image = "ghcr.io/${var.github_ghcr_owner}/nft-meta-athlete-webapp:latest"

          resources {
            limits = {
              cpu    = "1"
              memory = "1024Mi"
            }
            requests = {
              cpu    = "0.5"
              memory = "1024Mi"
            }
          }

          port {
            container_port = 80
          }
        }

        image_pull_secrets {
          name = "ghcr"
        }

        restart_policy = "Always"
      }
    }
  }

  depends_on = [kubernetes_secret_v1.ghcr]
}

resource "kubernetes_service_v1" "nft-meta-athlete-webapp" {
  metadata {
    name = "nft-meta-athlete-webapp"
  }

  spec {
    type = "ClusterIP"

    port {
      port        = 80
      target_port = 80
    }

    selector = {
      app = "nft-meta-athlete-webapp"
    }
  }
}

resource "kubernetes_ingress_v1" "nft-meta-athlete-webapp" {
  metadata {
    name = "nft-meta-athlete-webapp"
    annotations = {
      "kubernetes.io/ingress.class"    = "nginx"
      "cert-manager.io/cluster-issuer" = "letsencrypt-prod"
    }
  }

  spec {
    tls {
      hosts = [
        var.linode_domain
      ]

      secret_name = "nginx-tls"
    }

    rule {
      host = var.linode_domain

      http {
        path {
          path = "/"
          path_type = "Prefix"

          backend {
            service {
              name = "nft-meta-athlete-webapp"

              port {
                number = 80
              }
            }
          }
        }
      }
    }
  }
}
