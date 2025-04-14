variable "vm_admin_username" {
  description = "Virtual machine admin username."
  type        = string
  sensitive   = true
  default     = "vmadmin"
}

variable "vm_admin_password" {
  description = "Virtual machine admin password. Notice that this method is considered unsafe as the password is stored in the Terraform state file as plain text. I use this only for demostration purposes"
  type        = string
  sensitive   = true
  default     = null
}
