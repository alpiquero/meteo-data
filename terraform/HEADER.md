# Terraform

Here you can find the Terraform code to deploy a Linux Virtual Machine in Azure which can be used to deploy and run this repo services on it. This Terraform config also installs **Docker Engine** and **Docker Compose** using a [cloud-init](./files/cloudinit.yaml) template in order to allow the services to be executed.

## DISCLAIMER

This Terraform config has never been tested in a real Azure environment because I don't want to consume my Free Tier time and even some of the needed resources are not part of it, so I would be charged for them. Feel free to use it to deploy it into your own Azure account if you need it.

I also use an user/password combination to allow SSH into the deployed IaC. I know that this method is considered insecure and the use of an ssh key is preferable, but I'm only using this as demo purposes. Never for production.

## Requirements

* [terraform](https://terraform.io): v1.11.4
* [terraform-docs](https://terraform-docs.io) to generate this README.

## Deploying the IaC

Swich to the [terraform](./terraform) folder:

```shell
cd terraform
```

Initialize the Terraform config:

```shell
terraform init
```

Validate the Terraform config:
```
terraform validate
```

Check the changes (notice you will need Azure credentials for this):

```shell
terraform plan
```

Deploy changes (Azure credentials needed):

```shell
terraform apply
```

Show outputs:

```shell
terraform output
```

Destroy existing IaC:

```shell
terraform destroy
```

## Generate docs

Run the following to generate the README.md file

```shell
terraform-docs .
```
