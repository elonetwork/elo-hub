include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../terraform//infrastructure"
}

inputs = {
  bastion_vm_name = "vm-bastion"
  bastion_vm_size = "Standard_DS1_v2"
  bastion_storage_os_disk_name = "os-disk-bastion"
  bastion_computer_name = "hostname-bastion"
  bastion_username = "saijiro"
  bastion_storage_os_disk_caching = "ReadWrite"
  bastion_storage_os_disk_create_option = "FromImage"
  bastion_storage_os_disk_create_option = "Standard_LRS"
  bastion_storage_image_reference_publisher = "Canonical"
  bastion_storage_image_reference_offer = "UbuntuServer"
  bastion_storage_image_reference_sku = "18.04-LTS"
  bastion_storage_image_reference_version = "latest"
  squid_vm_name = "vm-squid"
  squid_vm_size = "Standard_DS1_v2"
  squid_storage_os_disk_name = "os-disk-squid"
  squid_computer_name = "hostname-squid"
  squid_username = "saijiro"
  squid_password = "Password@123"
  squid_storage_os_disk_caching = "ReadWrite"
  squid_storage_os_disk_create_option = "FromImage"
  squid_storage_os_disk_create_option = "Standard_LRS"
  squid_storage_image_reference_publisher = "Canonical"
  squidstorage_image_reference_offer = "UbuntuServer"
  squid_storage_image_reference_sku = "18.04-LTS"
  squid_storage_image_reference_version = "latest"
  vnet_hub_name = "vnet-hub"
  vnet_hub_address_space = "10.100.0.0/16"
  interface_bastion_name = "interface-bastion"
  interace_bastion_ip_config_name = "ipconfig-bastion"
  interace_bastion_ip_config_private_ip_allocation = "Dynamic"
  interface_squid_name = "interface-squid"
  interace_squid_ip_config_name = "ipconfig-squid"
  interace_squid_ip_config_private_ip_allocation = "Dynamic"
  sub_firewall_address_prefixes = "10.100.0.0/24"
  sub_firewall_mgm_address_prefixes = "10.100.1.0/24"
  sub_squid_address_prefixes = "10.100.2.0/24"
  sub_bastion_address_prefixes = "10.100.3.0/24"
  sub_firewall_name = "AzureFirewallSubnet"
  sub_firewall_mgm_name = "AzureFirewallManagementSubnet"
  sub_squid_address_name = "sub-squide"
  sub_bastion_address_name = "sub-bastion"
  
}