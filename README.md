# Akamai Infrastructure

This repository holds all of the necessary blueprints to set up the following
infrastructure resources:

- Linode Kubernetes Engine
- Linode Database Cluster (PostgreSQL 12.12)
- Akamai DNS

Alongside specific load balancing and networking configurations.

# Requirements

You need to have installed the following software on your computer:

- Docker version 23.0.1

# Getting started

To deploy the entire infrastructure, we first need to configure the project accordingly.

1. Start by copying the `example.config.tfvars` file into the `terraform` folder as `terraform.tfvars`. This file holds all configurations for the infrastructure and deployed images.

```
cp example.config.tfvars ./terraform/terraform.tfvars
```

2. Follow the next steps to generate the necessary tokens.

# Generating a GitHub Personal Access Token

To fetch the built images from the GitHub Container Registry, you're gonna
need a GitHub Personal Access Token with the necessary permissions.

1. Start by generating a GitHub Personal Token by accessing this link: https://github.com/settings/tokens

2. Generate a new token of type classic.

3. Choose a name and set your expiration date to "No expiration".

4. Define the following permission scopes:

<center>
<img src="https://i.imgur.com/6Uz5GNs.png" width="350" />
</center>

5. Configure the `default_github_pat` variable with the generated token in your `terraform.tfvars` file.

6. Set the `github_ghcr_owner` variable to the owner of the repositories you wish to deploy. All in lowercase. Example: `ssi-walt-login-id` and `nft-meta-athlete-webapp` are owned by `iccha-technologies`.

# Generating a Linode API key

To create resources and manipulate the infrastructure, Terraform needs access to your Linode account:

1. Access your token settings by going to this link: https://cloud.linode.com/profile/tokens

2. Select a name, expiration time, and generate a token with all permissions set.

3. Copy and save the token as it won't be displayed again in the Linode console.

<center>
<img src="https://i.imgur.com/eGhnUEU.png" width="200" />
</center>

4. Set the `linode_api_token` variable to the token generated using the Linode console in your `terraform.tfvars` file.

# Adjust your main domain

This infrastructure requires your domain to use the Akamai DNS nameservers. Head over to your domain registrar and adjust your domain's nameservers to the following records:

- ns1.linode.com
- ns2.linode.com
- ns3.linode.com
- ns4.linode.com
- ns5.linode.com

Each registrar has a way of configuring domains via their **web administration** panel. Allow at least 30 minutes after updating your domain to use the Akamai DNS nameservers.

You can check if your domain is ready to be used by running the following command using the `dig` program:


> Swap testdomain.com with your main domain

```
dig @1.1.1.1 testdomain.com NS
```

Check the returned `ANSWER SECTION` for the Akamai DNS nameservers:

```
;; ANSWER SECTION:
testdomain.com.		86400	IN	NS	ns1.linode.com.
testdomain.com.		86400	IN	NS	ns4.linode.com.
testdomain.com.		86400	IN	NS	ns2.linode.com.
testdomain.com.		86400	IN	NS	ns5.linode.com.
testdomain.com.		86400	IN	NS	ns3.linode.com.
```

If you see a response like this, it means your domain is ready to be used.

# Customize infrastructure resources

After you've supplied the necessary tokens, head to the `[Linode Settings]` block
and adjust all variables according to your infrastructure needs.

**[Linode Settings]**

| Config                     | Description                                                                                 |
| -------------------------- | ------------------------------------------------------------------------------------------- |
| linode_api_token           | Required Linode API token to create resources.                                              |
| linode_region              | Linode region all resources will be deployed to.                                            |
| linode_domain              | This is your main domain. It will be used to host all images.                               |
| linode_domain_soa_email    | This email address is used to send you notifications about your Let's Encrypt certificates. |
| linode_database_allow_list | This list allows specific public IP addresses to access your database cluster.              |
| linode_database_name       | Name of the database that will be created for the `ssi-walt-id-login` service.              |

**[ssi-walt-id-login Settings]**

These configurations are specific to the `ssi-walt-id-login` service and default values are already provided.

# Deploying the infrastructure

After you have copied the `example.config.tfvars` file into the `terraform` folder and finished configuring it. You will now be able to deploy the infrastructure with just one command using Docker Compose.

1. In the root of this folder (Where the Dockerfile is located), run the following command:

```
docker compose up
```

This will build and spawn an image with all dependencies installed and the subsequent Terraform commands to spawn the infrastructure.

2. Wait for Docker to finish. This is a process that can take a while due to the complexity of the infrastructure and DNS.

3. After the command is finished, backup your `terraform.tfstate`:

```
cp terraform/terraform.tfstate ./terraform.tfstate.backup
```

This step is very important, as losing your `terraform.tfstate` can render Terraform useless and desynchronize the infrastructure from the code.

# Updating the infrastructure

If you wish to push any changes performed to the `terraform.tfvars` configuration file, simply
rerun the already shown Docker Compose command:

```
docker compose up
```

# Destroying the infrastructure

Destroying infrastructure is an action that should never be performed unless you wish for the 
resources to be deleted permanently without rolling back. This includes backups/snapshots and preregistered public IP addresses that point to existing services.

If you wish to delete the infrastructure, you need to install the Terraform CLI tool in your computer
and perform a manual delete.

1. Head over to this link and install the official Terraform CLI tool: https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli

2. After installing it, simply navigate to the `terraform` folder and run the following commands:

```
terraform init && terraform destroy --auto-approve
```

These two commands will download all Terraform package dependencies and automatically
destroy resources without confirmation.

# Important notes to consider

1. Kubernetes deployments depend on the GitHub Container Registry and the `build-and-deploy` workflow installed in the following repositories:

- nft-meta-athlete-webapp
- ssi-walt-id-login

2. Infrastructure deployment/creation time is around 30 to 35 minutes due to DNS wait times and the complexity of resources.

3. DO NOT delete the `terraform.tfstate` file located inside the `terraform` folder. This will make Terraform lose track of all of the infrastructure resources.

4. Your `terraform.tfstate` file holds sensitive values such as your database password, etc.

5. After the infrastructure is deployed, HTTPS/SSL may return an invalid certification error. This is temporary until all major DNS nameservers have picked up your domain updates. This process is automatically checked every 10 seconds until the domain is verified by Let's Encrypt services
