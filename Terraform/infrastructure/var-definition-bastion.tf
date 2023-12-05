variable "bastion_vm_name" {
  description = "The name of the bastion virtual machine"
  default     = "bastion-vm"  # Replace with your default value
}

variable "admin_username" {
  description = "The username for the admin user"
  default     = "adminuser"  # Replace with your default value
}

variable "aks_service_principal" {
  type = map(string)
}

variable "tenant_id" {
  
}
