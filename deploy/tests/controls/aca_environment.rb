control "azure-container-app-environment" do
  title "Azure Container App Environment"
  desc "Ensure that the Azure Container App Environment has been deployed as expected"

  # Get all resources that match the criteria
  resources = azure_generic_resources(resource_group: input("rg_name"), name: input("acae_name"))

  # Filter for the Container App Environment
  acae_resource = resources.where(type: 'Microsoft.App/managedEnvironments').entries.first

  # Now test the specific resource
  describe acae_resource do
    it { should_not be_nil }
    its('id') { should_not be_nil }
    its('name') { should cmp input("acae_name") }
    its('location') { should cmp input("location").downcase }
    its('type') { should cmp 'Microsoft.App/managedEnvironments' }
    its('provisioningState') { should cmp "Succeeded" }
  end

  describe azure_generic_resource(resource_id: acae_resource.id) do
    it { should exist }
    its('properties.appLogsConfiguration.destination') { should cmp 'log-analytics' }
    its('properties.appLogsConfiguration.logAnalyticsConfiguration.customerId') { should_not be_nil }
  end
end


