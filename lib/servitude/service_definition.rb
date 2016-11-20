module Servitude
    class ServiceDefinition
       attr_accessible :name, :description, :language, :datastores, :message_types_consumed, :message_types_produced, :rest_dependencies
       
       def self.from(attributes)
           if !attributes.respond_to?(:stringify_keys)
               raise ArgumentError, "When assigning attributes, you must pass a hash as an argument."
           end
       end
    end
end