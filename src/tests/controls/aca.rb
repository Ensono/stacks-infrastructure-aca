control "azure-container-app" do
  title "Azure Container App"
  desc "Ensure that the Azure Container App has been deployed as expected"

  rg_name = input('rg_name')
  aca_name = input('aca_name')
  aca_id = input('aca_id')
  aca_fqdn = input('aca_fqdn')

  # Get the Container App resource
  describe azure_generic_resource(resource_group: rg_name, name: aca_name) do
    it { should exist }
    its('id') { should match(/#{Regexp.escape(aca_id)}/i) }
    its('name') { should eq aca_name }
    its('type') { should eq 'Microsoft.App/containerApps' }
    its('properties.provisioningState') { should cmp 'Succeeded' }
    its('properties.managedEnvironmentId') { should_not be_nil }
    its('properties.configuration.ingress.fqdn') { should eq aca_fqdn }
    
    # Check for the presence of containers
    it 'should have at least one container' do
      expect(subject.properties.template.containers.length).to be > 0
    end

    # Check specific container properties
    its('properties.template.containers.first.name') { should_not be_nil }
    its('properties.template.containers.first.image') { should_not be_nil }

    # Check for revision mode
    its('properties.configuration.activeRevisionsMode') { should_not be_nil }

    # Check for ingress configuration
    its('properties.configuration.ingress.external') { should_not be_nil }
    its('properties.configuration.ingress.targetPort') { should_not be_nil }

    # Check for min and max replicas
    its('properties.template.scale.minReplicas') { should_not be_nil }
    its('properties.template.scale.maxReplicas') { should_not be_nil }
  end
end
