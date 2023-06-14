resource "kubernetes_deployment_v1" "ssikit" {
  metadata {
    name = "ssikit"
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "ssikit"
      }
    }

    template {
      metadata {
        labels = {
          app = "ssikit"
        }
      }

      spec {
        container {
          name  = "ssikit"
          image = "waltid/ssikit:latest"

          port {
            container_port = 7000
          }
          port {
            container_port = 7001
          }
          port {
            container_port = 7002
          }
          port {
            container_port = 7003
          }
          port {
            container_port = 7004
          }
          port {
            container_port = 7010
          }

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

          command = ["/app/bin/waltid-ssikit"]
          args    = ["serve", "-b", "0.0.0.0"]
        }
      }
    }
  }
}

resource "kubernetes_service_v1" "ssikit" {
  metadata {
    name = "ssikit"
  }

  spec {
    type = "ClusterIP"

    port {
      name = "ssikit-signatory"
      port        = 7001
      target_port = 7001
    }

    port {
      name = "ssikit-custodian"
      port        = 7002
      target_port = 7002
    }

    port {
      name = "ssikit-auditor"
      port        = 7003
      target_port = 7003
    }

    selector = {
      app = "ssikit"
    }
  }
}
