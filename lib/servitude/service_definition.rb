module Servitude
  class ServiceDefinition
    attr_accessor :name,
                  :description,
                  :language,
                  :datastores,
                  :message_types_consumed,
                  :message_types_produced,
                  :rest_dependencies

    def self.from(attributes)
      definition = ServiceDefinition.new

      return definition if attributes.nil?

      attributes.each do |k, v|
        definition.send("#{k}=", v) if definition.respond_to?("#{k}=")
      end

      definition
    end
  end
end
