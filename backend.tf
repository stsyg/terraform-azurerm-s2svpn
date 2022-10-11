# Terraform Cloud configuration
terraform {
  cloud {
    organization = "The38Dev"
    workspaces {
      name = "terraform-azurerm-s2svpn"
    }
  }
}