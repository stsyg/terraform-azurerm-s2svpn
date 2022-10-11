# Deployment of Azure Site to Site (S2S) VPN

The following resources will be created:

- Azure Local Network Gateway
- Azure Virtual Private Network (VPN) Gateway
- Connection between Local Network Gateway and VPN Gateway
- Azure Public IP

Router Public IP and shared keys are taken from the infrastructure KeyVault deployed using https://github.com/stsyg/terraform-azurerm-kv