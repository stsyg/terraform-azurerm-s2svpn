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

# Get public IP address
data "external" "myipaddr" {
  program = ["bash", "-c", "curl -s 'https://ipinfo.io/json'"]
}

# Create Local Network Gateway (LNG)
resource "azurerm_local_network_gateway" "this" {
  name                = "${var.prefix}-${var.service}-lng"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  gateway_address     = "xx.xx.xx.xx" #--Your local device / router public IP here
  address_space       = var.peer_subnet_address_spaces
}

resource "azurerm_public_ip" "this" {
  name                = var.vpn_public_ip
  location            = var.location
  resource_group_name = var.resource_group
  allocation_method   = "Dynamic" #--Dynamic set means Azure will generate an IP for your Azure VPN Gateway
}

resource "azurerm_virtual_network_gateway" "this" {
  name                = var.vpn_gateway
  location            = var.location
  resource_group_name = var.resource_group
  type                = "Vpn"        #--Other option is ExpressRoute, predictably for ExpressRoute VPNs
  vpn_type            = "RouteBased" #--Policy based is also acceptable here, depending on your use case
  active_active       = false
  enable_bgp          = false
  sku                 = "Basic" #--A whole load of oddities occur around SKUs, see MS Docs for details
  ip_configuration {
    public_ip_address_id          = azurerm_public_ip.this.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = data.azurerm_subnet.this.0.id #--There's that ID we needed, for the Transport Subnet
  }
}

resource "azurerm_virtual_network_gateway_connection" "this" {
  name                       = var.vpn_connection
  location                   = var.location
  resource_group_name        = var.resource_group
  type                       = "IPsec"
  virtual_network_gateway_id = azurerm_virtual_network_gateway.this.id
  local_network_gateway_id   = azurerm_local_network_gateway.madcaplaughs.id
  shared_key                 = var.vpn_psk #-Provided at run time
}