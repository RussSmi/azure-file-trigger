locals {
  resource_location   = lower(replace(var.location, " ", ""))
  resource_group_name = "rg-${var.ident}-${var.loc}-${var.env}"
}
#-------------------------------
# Create main resource group
#-------------------------------
resource "azurerm_resource_group" "file-trigger" {
  name     = local.resource_group_name
  location = local.resource_location
}

#-------------------------------
# calling the Storage module
#-------------------------------
module "storage" {
  source   = "./modules/storage"
  location = local.resource_location
  ident    = var.ident
  rg       = azurerm_resource_group.file-trigger.name
  env      = var.env
  instance = var.instance
}
