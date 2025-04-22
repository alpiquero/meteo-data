# Ansible

Here you can find the Ansible code that can be used to deploy and run this repo services into an hypothetical Azure environment.

The plabook performs the following tasks in the destination host:
1. Create a folder in which the code of the services will be placed.
2. Copies the [compose.yaml](../compose.yaml) and the [weather](../weather/) folder into it.
3. Ensures the services are running and updates them in case changes had occurred in the config or in the code.

## Requirements

* [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html) >= 2.18
* An Azure account for being used with the [Azure Dynamic Inventory](https://learn.microsoft.com/en-us/azure/developer/ansible/dynamic-inventory-configure) plugin.

## Playbook Requirements

All requirements needed for this playbook can be installed by running the following:

```shell
ansible-galaxy install -r requirements.txt
```

## Executing the playbook

```shell
ansible-playbook playbook.yml
```

The playbook will ask interactively for the admin username and password in order to use them to authenticate into the Azure Virtual Machine and perform the services installation and running tasks. You can retrieve them from the [Terraform](../terraform/README.md) outputs.

