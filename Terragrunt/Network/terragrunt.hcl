include "root" {
  paths = ["../Security/"]
}

dependency "subnet-squid" {
  config_path = "../Infrastructure/"
}

dependency "firewall_private_ip_address" {
  config_path = "../Security/"
}

inputs = {
  route-table-name="route-table"
  subnet-squid-id = dependency.subnet-squid.outputs.subnet-squid-id
  route-squid-name="route-squid-to-http"
  route-address-prefix="0.0.0.0/0"
  route-squid-next-hop-type="VirtualAppliance"
  route-squid-next_hop_in_ip_address=dependency.firewall_private_ip_address.outputs.firewall_private_ip_address
}
