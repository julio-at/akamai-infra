resource "linode_domain" "main-domain" {
  type      = "master"
  domain    = var.linode_domain
  soa_email = var.linode_domain_soa_email
}

resource "linode_domain_record" "main-domain-webapp" {
  domain_id   = linode_domain.main-domain.id
  record_type = "A"
  target      = data.local_file.ingress_nginx_external_ip.content
  ttl_sec     = 30

  depends_on = [null_resource.get_ingress_nginx_external_ip]
}

resource "linode_domain_record" "ssi" {
  domain_id   = linode_domain.main-domain.id
  name        = "ssi"
  record_type = "A"
  target      = data.local_file.ingress_nginx_external_ip.content
  ttl_sec     = 30

  depends_on = [null_resource.get_ingress_nginx_external_ip]
}
