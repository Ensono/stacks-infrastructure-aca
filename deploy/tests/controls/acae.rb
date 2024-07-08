# Inspec Documentation for further testing development:
## https://docs.chef.io/inspec/resources/azure_generic_resources/

title "Azure Container App Environment"

# Ensure that the resource group exists, is in the correct location and
# has been provisionned successfully
describe azure_generic_resource(resource_group: input("rg_name"), name: input("acae_name")) do
  it { should exist }
  its("location") { should cmp input("location") }
  its("properties.provisioningState") { should cmp "Succeeded" }
  its('type') { should cmp 'Microsoft.App/managedEnvironments' }
  its('properties.provisioningState') { should cmp 'Succeeded' }

   # Check if it's associated with a Log Analytics workspace
   its('properties.appLogsConfiguration.destination') { should cmp 'log-analytics' }
   its('properties.appLogsConfiguration.logAnalyticsConfiguration.customerId') { should_not be_nil }
end
