prefix   = "infra"
service  = "s2svpn"
location = "canadacentral"

name_vnet          = "infra-vnet-01"
name_vnet_rg       = "infra-network-rg"
name_kv            = "keyvaultb2f5cd5138"
name_kv_rg         = "infra-keyvault-rg"
secret_name01      = "routerpip"
secret_name02      = "vpngwkey"
lng_address_spaces = ["10.174.5.0/24",]

default_tags = {
  environment = "Lab"
  designation = "Infrastructure"
  provisioner = "Terraform"
}