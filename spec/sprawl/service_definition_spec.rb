require 'spec_helper'

describe Sprawl::ServiceDefinition do
  it 'from generates a new definition from a hash' do
    hash = {
      'name' => 'Test Service',
      'description' => 'Does cool things',
      'language' => 'Ruby',
      'datastores' => ['Postgresql'],
      'message_types_consumed' => ['Consumable Message'],
      'message_types_produced' => ['Producable Message'],
      'rest_dependencies' => ['That other service']
    }

    definition = Sprawl::ServiceDefinition.from(hash)

    expect(definition.name).to eq('Test Service')
    expect(definition.description).to eq('Does cool things')
    expect(definition.language).to eq('Ruby')
    expect(definition.datastores).to eq(['Postgresql'])
    expect(definition.message_types_consumed).to eq(['Consumable Message'])
    expect(definition.message_types_produced).to eq(['Producable Message'])
    expect(definition.rest_dependencies).to eq(['That other service'])
  end
end
