targetScope = 'resourceGroup'

module storage 'modules/storage.bicep' = {
name: 'storage'
params: {
  prefix: 'fileshr'
  }
}
