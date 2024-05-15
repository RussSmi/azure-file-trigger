@description('Location for all resources.')
param location string = resourceGroup().location

@description('Prefix for storage account name')
@maxLength(9)
param prefix string

var storageAccountName = '${prefix}${uniqueString(resourceGroup().id)}'
var fileShareNameInbound = 'inbound'
var fileShareNameArchive = 'archive'

resource storageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
  }
}

resource blobServices 'Microsoft.Storage/storageAccounts/blobServices@2023-01-01' = {
  parent: storageAccount
  name: 'default'
}

// add azure file services
resource fileServices 'Microsoft.Storage/storageAccounts/fileServices@2023-04-01' = {
  parent: storageAccount
  name: 'default'
}

resource fileShareInbound 'Microsoft.Storage/storageAccounts/fileServices/shares@2023-04-01' = {
  parent: fileServices
  name: fileShareNameInbound
}

resource fileShareArchive 'Microsoft.Storage/storageAccounts/fileServices/shares@2023-04-01' = {
  parent: fileServices
  name: fileShareNameArchive
}

resource tableServices 'Microsoft.Storage/storageAccounts/tableServices@2023-04-01' = {
  parent: storageAccount
  name: 'default'
}

resource auditTable 'Microsoft.Storage/storageAccounts/tableServices/tables@2023-04-01' = {
  parent: tableServices
  name: 'audit'  
}

resource blobContainers 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-04-01' = {
  parent: blobServices
  name: 'backed-api'
}

output storageAccountName string = storageAccount.name
