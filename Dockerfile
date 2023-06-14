FROM debian:bullseye

# Install all dependencies
RUN apt update && apt upgrade -y
RUN apt install -y curl unzip postgresql-client wget
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
RUN install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

RUN wget https://releases.hashicorp.com/terraform/1.5.0/terraform_1.5.0_linux_amd64.zip
RUN unzip terraform_1.5.0_linux_amd64.zip
RUN mv terraform /usr/bin/terraform

# Set the working directory
WORKDIR /infrastructure

# Copy Terraform files to the container
COPY ./terraform/ /infrastructure/

# Run Terraform commands
CMD [ "bash", "-c", "terraform init && terraform apply -auto-approve"]
