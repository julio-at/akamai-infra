resource "helm_release" "cert-manager" {
  name       = "cert-manager"
  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"
  namespace  = "cert-manager"

  depends_on = [
    kubernetes_namespace_v1.cert-manager,
    helm_release.ingress-nginx,
  ]
}
