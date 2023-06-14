resource "kubernetes_namespace_v1" "cert-manager" {
  metadata {
    name = "cert-manager"
  }

  depends_on = [linode_lke_cluster.main-lke-cluster]
}

resource "null_resource" "install_cert_manager_crds" {
  provisioner "local-exec" {
    command = <<EOT
cat >/tmp/ca.crt <<EOF
${base64decode(local.lke_kubeconfig.clusters.0.cluster.certificate-authority-data)}
EOF
kubectl \
  --server="${local.lke_kubeconfig.clusters.0.cluster.server}" \
  --certificate_authority=/tmp/ca.crt \
  --token="${local.lke_kubeconfig.users.0.user.token}" \
  apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.8.0/cert-manager.crds.yaml
EOT

    interpreter = ["bash", "-c"]
  }

  depends_on = [kubernetes_namespace_v1.cert-manager]
}
