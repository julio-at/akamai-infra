# This is the main configuration file for the infrastructure.
# Adjust the values below to your needs.
#
# After adjusting this file, copy it into the "terraform" 
# folder as "terraform.tfvars"

# [GitHub Settings - Required]
#
# Required GitHub configuration to access deployed images.
default_github_pat = "ghp_..."
github_ghcr_owner  = "iccha-technologies"

# [Linode Settings]
#
# Required Linode API token to create resources.
linode_api_token = "your_private_linode_api_token"
# Linode region all resources will be deployed to.
linode_region    = "us-central"
# This is your main domain. It will be used to host all deployments.
linode_domain = "domain.com"
# This email address is used to send you notifications about your Let's Encrypt certificates.
linode_domain_soa_email = "john.doe@domain.com"
# This list allows specific public IP addresses to access your database cluster.
# While not recommended, you can set this to 0.0.0.0/0 if you want to allow authentication
# from any IP address.
linode_database_allow_list = [
  "0.0.0.0/0"
]
# This is the name of the database that will be created for the ssi-walt-id-login service.
linode_database_name = "nftmeta"

# [ssi-walt-id-login Settings]
#
# The following settings are used to configure the ssi-walt-id-login service. These
# values are passed to the service as environment variables.
ssikit_host           = "ssikit"
ssikit_signatory_port = 7001
ssikit_custodian_port = 7002
ssikit_auditor_port   = 7003

ssikit_fastapi_port = 8000

ssikit_fastapi_development = false
ssikit_api_key             = "meta_athlete"
ssikit_api_key_name        = "api_key"

ssikit_issuer_did     = "did:key:z6MkwGzSc39Hff2Y9ZtmzLp8d46RcP6v6gc1R3r6C4AipRWS"
ssikit_vc_template_id = "PythonCredential"
