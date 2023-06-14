resource "kubernetes_config_map_v1" "ssi-walt-id-login" {
  metadata {
    name = "ssi-walt-id-login-config"
  }

  data = {
    HOST = var.ssikit_host

    SIGNATORY_PORT = var.ssikit_signatory_port
    CUSTODIAN_PORT = var.ssikit_custodian_port
    AUDITOR_PORT   = var.ssikit_auditor_port

    FAST_API_PORT       = var.ssikit_fastapi_port
    FASTAPI_DEVELOPMENT = var.ssikit_fastapi_development

    DB_USERNAME = local.database_username
    DB_PASSWORD = local.database_password
    DB_HOST     = local.database_host
    DB_PORT     = local.database_port
    DB_NAME     = var.linode_database_name

    API_KEY      = var.ssikit_api_key
    API_KEY_NAME = var.ssikit_api_key_name

    ISSUER_DID     = var.ssikit_issuer_did
    VC_TEMPLATE_ID = var.ssikit_vc_template_id
  }

  depends_on = [kubernetes_secret_v1.ghcr]
}

resource "kubernetes_deployment_v1" "ssi-walt-id-login" {
  metadata {
    name = "ssi-walt-id-login"
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "ssi-walt-id-login"
      }
    }

    template {
      metadata {
        labels = {
          app = "ssi-walt-id-login"
        }
      }

      spec {
        container {
          name  = "ssi-walt-id-login"
          image = "ghcr.io/${var.github_ghcr_owner}/ssi-walt-id-login:latest"

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
            container_port = 8000
          }

          env_from {
            config_map_ref {
              name = "ssi-walt-id-login-config"
            }
          }
        }

        image_pull_secrets {
          name = "ghcr"
        }

        restart_policy = "Always"
      }
    }
  }

  depends_on = [kubernetes_config_map_v1.ssi-walt-id-login]
}

resource "kubernetes_service_v1" "ssi-walt-id-login" {
  metadata {
    name = "ssi-walt-id-login"
  }

  spec {
    type = "ClusterIP"

    port {
      port        = 80
      target_port = 8000
    }

    selector = {
      app = "ssi-walt-id-login"
    }
  }

  depends_on = [kubernetes_deployment_v1.ssi-walt-id-login]
}

resource "kubernetes_ingress_v1" "ssi-walt-id-login" {
  metadata {
    name = "ssi-walt-id-login"
    annotations = {
      "kubernetes.io/ingress.class"    = "nginx"
      "cert-manager.io/cluster-issuer" = "letsencrypt-prod"
      "nginx.ingress.kubernetes.io/rewrite-target" : "/"
    }
  }

  spec {
    tls {
      hosts = [
        "ssi.${var.linode_domain}"
      ]

      secret_name = "nginx-ssi"
    }

    rule {
      host = "ssi.${var.linode_domain}"

      http {
        path {
          path      = "/"
          path_type = "Prefix"

          backend {
            service {
              name = "ssi-walt-id-login"

              port {
                number = 80
              }
            }
          }
        }
      }
    }
  }

  depends_on = [kubernetes_deployment_v1.ssi-walt-id-login]
}
