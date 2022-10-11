# Deployment of Azure Site to Site (S2S) VPN

The following resources will be created:

- Azure Local Network Gateway
- Azure Virtual Private Network (VPN) Gateway
- Connection between Local Network Gateway and VPN Gateway
- Azure Public IP

| Note: Since Azure VPN Gateway is deployed to the same RG as vNet, the code should be executed in the following sequence:
1. Build Azure Key Vault using https://github.com/stsyg/terraform-azurerm-kv
2. Create router pPublic IP and Azure VPN GW connection pre-shared key. Upload them to the KeyVault
3. Build infrastructure vNets/Subnets first using https://github.com/stsyg/terraform-azurerm-network
4. Build Azure VPN second using this repo
5. After successful deployment of the resources, it will take up to 5 minutes to show status of the connection as connected