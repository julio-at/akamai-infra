resource "helm_release" "ingress-nginx" {
  name       = "ingress-nginx"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"

  depends_on = [kubernetes_deployment_v1.nft-meta-athlete-webapp]
}

resource "null_resource" "get_ingress_nginx_external_ip" {
  provisioner "local-exec" {
    command = <<EOT
cat >/tmp/ca.crt <<EOF
${base64decode(local.lke_kubeconfig.clusters.0.cluster.certificate-authority-data)}
EOF
kubectl \
  --server="${local.lke_kubeconfig.clusters.0.cluster.server}" \
  --certificate_authority=/tmp/ca.crt \
  --token="${local.lke_kubeconfig.users.0.user.token}" \
  -n default get services -o wide ingress-nginx-controller --output jsonpath='{.status.loadBalancer.ingress[0].ip}' > /tmp/ingress-nginx-external-ip
EOT

    interpreter = ["bash", "-c"]
  }

  triggers = {
    always_run = timestamp()
  }

  depends_on = [helm_release.ingress-nginx]
}

data "local_file" "ingress_nginx_external_ip" {
  filename = "/tmp/ingress-nginx-external-ip"

  depends_on = [null_resource.get_ingress_nginx_external_ip]
}

output "ingress-nginx-external-ip" {
  value = data.local_file.ingress_nginx_external_ip.content
}
