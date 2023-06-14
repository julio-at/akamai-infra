variable "default_github_pat" {
  type        = string
  description = "GitHub Personal Access Token to access GitHub Container Registry"
}

variable "github_ghcr_owner" {
  type        = string
  description = "GitHub Personal Access Token to access GitHub Container Registry"
}

variable "linode_api_token" {
  type        = string
  description = "Linode APIv4 Token"
}

variable "linode_region" {
  type        = string
  description = "Linode region to deploy resources to"
}

variable "linode_domain" {
  type        = string
  description = "Main domain for the Linode account"
}

variable "linode_domain_soa_email" {
  type        = string
  description = "Email address for the SOA record of the main domain"
}

variable "linode_database_allow_list" {
  type        = list(string)
  description = "List of IP addresses to allow access to the database"
  default     = ["0.0.0.0/0"]
}

variable "linode_database_name" {
  type = string
}

variable "ssikit_host" {
  type    = string
  default = "ssikit"
}

variable "ssikit_signatory_port" {
  type    = number
  default = 7001
}

variable "ssikit_custodian_port" {
  type    = number
  default = 7002
}

variable "ssikit_auditor_port" {
  type    = number
  default = 7003
}

variable "ssikit_fastapi_port" {
  type    = number
  default = 8000
}

variable "ssikit_fastapi_development" {
  type    = bool
  default = false
}

variable "ssikit_api_key" {
  type    = string
  default = "meta_athlete"
}

variable "ssikit_api_key_name" {
  type    = string
  default = "api_key"
}

variable "ssikit_issuer_did" {
  type    = string
  default = "did:key:z6MkwGzSc39Hff2Y9ZtmzLp8d46RcP6v6gc1R3r6C4AipRWS"
}

variable "ssikit_vc_template_id" {
  type    = string
  default = "PythonCredential"
}
