<!-- BEGIN_TF_DOCS -->
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

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | 1.11.4 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 4.26.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.7.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 4.26.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.7.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_linux_virtual_machine.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine) | resource |
| [azurerm_network_interface.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface) | resource |
| [azurerm_network_security_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_public_ip.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_resource_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_subnet.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet_network_security_group_association.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association) | resource |
| [azurerm_virtual_network.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |
| [random_password.password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_vm_admin_password"></a> [vm\_admin\_password](#input\_vm\_admin\_password) | Virtual machine admin password. If not provided, a 16 length random password will be generated. Notice that this method is considered unsafe as the password is stored in the Terraform state file as plain text. I use this only for demostration purposes | `string` | `null` | no |
| <a name="input_vm_admin_username"></a> [vm\_admin\_username](#input\_vm\_admin\_username) | Virtual machine admin username. | `string` | `"vmadmin"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_azure_resource_group_name"></a> [azure\_resource\_group\_name](#output\_azure\_resource\_group\_name) | The name of the resource group |
| <a name="output_virtual_machine_admin_password"></a> [virtual\_machine\_admin\_password](#output\_virtual\_machine\_admin\_password) | The admin password of the virtual machine |
| <a name="output_virtual_machine_admin_username"></a> [virtual\_machine\_admin\_username](#output\_virtual\_machine\_admin\_username) | The admin username of the virtual machine |
| <a name="output_virtual_machine_name"></a> [virtual\_machine\_name](#output\_virtual\_machine\_name) | The name of the virtual machine |
| <a name="output_virtual_machine_public_ip"></a> [virtual\_machine\_public\_ip](#output\_virtual\_machine\_public\_ip) | The public IP address attached to the virtual machine |
<!-- END_TF_DOCS -->
