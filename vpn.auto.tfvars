prefix   = "infra"
service  = "s2svpn"
location = "canadacentral"

name_vnet    = "infra-vnet-01"
name_vnet_rg = "infra-network-rg"

default_tags = {
  environment = "Lab"
  designation = "Infrastructure"
  provisioner = "Terraform"
}