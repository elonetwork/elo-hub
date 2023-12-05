

variable "squid_vm_name" {
  description = "The name of the Squid VM"
  default     = "squid-vm"
}

variable "squid_vm_size" {
  description = "The size of the Squid VM"
  default     = "Standard_F2"  # Set your desired VM size
}

variable "squid_vm_admin_username" {
  description = "The admin username for the Squid VM"
  default     = "squidadmin"
}

variable "squid_vm_admin_password" {
  description = "The admin password for the Squid VM"
  default     = "Y2g8G3M5<Rw="  # Set your desired admin password
}

variable "squid_vm_os_disk_name" {
  description = "The name of the OS disk for the Squid VM"
  default     = "squid-os-disk"
}

variable "squid_vm_source_image_publisher" {
  description = "The publisher of the source image for Squid VM"
  default     = "Canonical"
}

variable "squid_vm_source_image_offer" {
  description = "The offer of the source image for Squid VM"
  default     = "UbuntuServer"
}

variable "squid_vm_source_image_sku" {
  description = "The SKU of the source image for Squid VM"
  default     = "18.04-LTS"
}

variable "squid_vm_source_image_version" {
  description = "The version of the source image for Squid VM"
  default     = "latest"
}

variable "squid_vm_disable_password_authentication" {
  description = "Disable password authentication for Squid VM"
  type        = bool
  default     = false
}

variable "squid_vm_os_disk_caching" {
  description = "Caching type for the Squid VM OS Disk"
  default     = "ReadWrite"
}

variable "squid_vm_os_disk_storage_account_type" {
  description = "Storage account type for Squid VM OS Disk"
  default     = "Standard_LRS"
}
