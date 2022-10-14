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
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~>3.24.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.24.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_local_network_gateway.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/local_network_gateway) | resource |
| [azurerm_public_ip.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_resource_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_virtual_network_gateway.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_gateway) | resource |
| [azurerm_virtual_network_gateway_connection.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_gateway_connection) | resource |
| [azurerm_key_vault.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault) | data source |
| [azurerm_key_vault_secret.pip](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.vpngwkey](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_subnet.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_default_tags"></a> [default\_tags](#input\_default\_tags) | Default tags to add to deployed resources | `map(string)` | n/a | yes |
| <a name="input_lng_address_spaces"></a> [lng\_address\_spaces](#input\_lng\_address\_spaces) | Local Network Gateway address space | `list(string)` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Location name used in Azure resources naming convention | `string` | n/a | yes |
| <a name="input_name_kv"></a> [name\_kv](#input\_name\_kv) | Name of the KeyVault | `string` | n/a | yes |
| <a name="input_name_kv_rg"></a> [name\_kv\_rg](#input\_name\_kv\_rg) | Name of the KeyVault resource group | `string` | n/a | yes |
| <a name="input_name_vnet"></a> [name\_vnet](#input\_name\_vnet) | Name of the vNet | `string` | n/a | yes |
| <a name="input_name_vnet_rg"></a> [name\_vnet\_rg](#input\_name\_vnet\_rg) | Name of the vNet resource group | `string` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Prefix used in Azure resources naming convention | `string` | n/a | yes |
| <a name="input_secret_name01"></a> [secret\_name01](#input\_secret\_name01) | Name of the secret #01 in KeyVault | `string` | n/a | yes |
| <a name="input_secret_name02"></a> [secret\_name02](#input\_secret\_name02) | Name of the secret #02 in KeyVault | `string` | n/a | yes |
| <a name="input_service"></a> [service](#input\_service) | Service name used in Azure resources naming convention | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
