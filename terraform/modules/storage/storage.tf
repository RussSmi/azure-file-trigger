locals {
  storage_account_name = "stg${var.ident}${var.env}${random_string.random.result}"
}
resource "random_string" "random" {
  length  = 5
  special = false
  upper   = false
}
resource "azurerm_storage_account" "file-trigger" {
  name                     = local.storage_account_name
  resource_group_name      = var.rg
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = var.env
  }
}

resource "azurerm_storage_container" "containers" {
  count                 = length(var.storage_container_names)
  name                  = var.storage_container_names[count.index]
  storage_account_name  = azurerm_storage_account.file-trigger.name
  container_access_type = "private"
}

resource "azurerm_storage_share" "shares" {
  count                = length(var.storage_fileshare_names)
  name                 = var.storage_fileshare_names[count.index]
  storage_account_name = azurerm_storage_account.file-trigger.name
  quota                = 2
}

# 
resource "azurerm_storage_table" "audit" {
  name                 = "audit"
  storage_account_name = azurerm_storage_account.file-trigger.name
}