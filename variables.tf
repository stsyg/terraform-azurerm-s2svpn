variable "prefix" {
  type        = string
  description = "Prefix used in Azure resources naming convention"
}

variable "service" {
  type        = string
  description = "Service name used in Azure resources naming convention"
}

variable "location" {
  type        = string
  description = "Location name used in Azure resources naming convention"
}

variable "default_tags" {
  type        = map(string)
  description = "Default tags to add to deployed resources"
}

variable "name_vnet_rg" {
  type        = string
  description = "Name of the vNet resource group"
}
variable "name_vnet" {
  type        = string
  description = "Name of the vNet"
}

variable "name_kv" {
  type        = string
  description = "Name of the KeyVault"
}
variable "name_kv_rg" {
  type        = string
  description = "Name of the KeyVault resource group"
}
variable "secret_name01" {
  type        = string
  description = "Name of the secret #01 in KeyVault"
}
variable "secret_name02" {
  type        = string
  description = "Name of the secret #02 in KeyVault"
}
variable "lng_address_spaces" {
  type        = list(string)
  description = "Local Network Gateway address space"
}
