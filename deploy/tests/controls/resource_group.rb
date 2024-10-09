# Inspec Documentation for further testing development:
## https://docs.chef.io/inspec/resources/azure_resource_group/

title "Resource Group"

# Ensure that the resource group exists, is in the correct location and
# has been provisionned successfully
describe azure_resource_group(name: input("resource_group_name")) do
  it { should exist }
  its("location") { should cmp input("location") }
  its("properties.provisioningState") { should cmp "Succeeded" }
end
