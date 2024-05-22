locals {
  storage_account_name = "stg${var.ident}${var.env}${random_string.randomla.result}"
  service_plan_name    = "asp-${var.ident}-${var.env}-${random_string.randomla.result}"
  logic_app_name       = "la-${var.ident}-${var.env}-${random_string.randomla.result}"
}
resource "random_string" "randomla" {
  length  = 5
  special = false
  upper   = false
}
resource "azurerm_storage_account" "file-trigger-la" {
  name                     = local.storage_account_name
  resource_group_name      = var.rg
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = var.env
  }
}

resource "azurerm_app_service_plan" "file-trigger-la" {
  name                = local.service_plan_name
  location            = var.location
  resource_group_name = var.rg
  kind                = "elastic"

  sku {
    tier = "WorkflowStandard"
    size = "WS1"
  }
}

resource "azurerm_logic_app_standard" "file-trigger-la" {
  name                       = local.logic_app_name
  location                   = var.location
  resource_group_name        = var.rg
  app_service_plan_id        = azurerm_app_service_plan.file-trigger-la.id
  storage_account_name       = azurerm_storage_account.file-trigger-la.name
  storage_account_access_key = azurerm_storage_account.file-trigger-la.primary_access_key

  app_settings = {
    "FUNCTIONS_WORKER_RUNTIME"     = "node"
    "WEBSITE_NODE_DEFAULT_VERSION" = "~18"
    "WORKFLOWS_RESOURCE_GROUP_NAME": var.rg,
    "WORKFLOWS_LOCATION_NAME": var.location,
    "WORKFLOWS_MANAGEMENT_BASE_URI": "https://management.azure.com/",
    "AzureFile_storageAccountUri": "https://${var.external_storage_name}.file.core.windows.net/inbound",
    "AzureFile_11_storageAccountUri": "https://${var.external_storage_name}.file.core.windows.net",
    "azureTables_tableStorageEndpoint": "https://${var.external_storage_name}.table.core.windows.net",
    "AzureBlob_blobStorageEndpoint": "https://${var.external_storage_name}.blob.core.windows.net",
  }
}