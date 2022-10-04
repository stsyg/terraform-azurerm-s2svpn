# Create Resource Group for S2S VPN
resource "azurerm_resource_group" "this" {
  name     = "${var.prefix}-${var.service}-rg"
  location = var.location

  tags = var.default_tags
}

# Check the existing vNet/Subnet to identify GatewaySubnet
data "azurerm_subnet" "this" {
  name                 = "GatewaySubnet"
  resource_group_name  = var.name_vnet_rg
  virtual_network_name = var.name_vnet
}

# Get infrastructure KeyVault details, to retrieve secrets later
data "azurerm_key_vault" "this" {
  name                = var.name_kv
  resource_group_name = var.name_kv_rg
}

# Get router public IP from infrastructure KeyVault
data "azurerm_key_vault_secret" "pip" {
  name         = var.secret_name01
  key_vault_id = data.azurerm_key_vault.this.id
}

# Get router VPN GW pre-shared key from infrastructure KeyVault
data "azurerm_key_vault_secret" "vpngwkey" {
  name         = var.secret_name02
  key_vault_id = data.azurerm_key_vault.this.id
}

# Create Local Network Gateway (LNG)
resource "azurerm_local_network_gateway" "this" {
  name                = "${var.prefix}-${var.service}-lng01"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  gateway_address     = data.azurerm_key_vault_secret.pip.value #--Your local device / router public IP here
  address_space       = var.lng_address_spaces
}

# Create public IP for VPN Gateway 
resource "azurerm_public_ip" "this" {
  name                = "${var.prefix}-${var.service}-pip01"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  allocation_method   = "Dynamic" #--Dynamic set means Azure will generate an IP for your Azure VPN Gateway
}

# Create VPN Gateway
resource "azurerm_virtual_network_gateway" "this" {
  name                = "${var.prefix}-${var.service}-vpngw01"
  location            = azurerm_resource_group.this.location
  resource_group_name = data.azurerm_subnet.this.resource_group_name
  type                = "Vpn"        #--Other option is ExpressRoute, predictably for ExpressRoute VPNs
  vpn_type            = "RouteBased" #--Policy based is also acceptable here, depending on your use case
  active_active       = false
  enable_bgp          = false
  sku                 = "VpnGw1" #--A whole load of oddities occur around SKUs, see MS Docs for details
  ip_configuration {
    public_ip_address_id          = azurerm_public_ip.this.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = data.azurerm_subnet.this.id #--There's that ID we needed, for the Transport Subnet
  }
}

# Create connection between Local Network Gateway and VPN Gateway
resource "azurerm_virtual_network_gateway_connection" "this" {
  name                       = "${var.prefix}-${var.service}-connect01"
  location                   = azurerm_resource_group.this.location
  resource_group_name        = data.azurerm_subnet.this.resource_group_name
  type                       = "IPsec"
  virtual_network_gateway_id = azurerm_virtual_network_gateway.this.id
  local_network_gateway_id   = azurerm_local_network_gateway.this.id
  shared_key                 = data.azurerm_key_vault_secret.vpngwkey.value #-Provided at run time
}