require 'yaml'
require 'servitude/service_definition'

module Servitude
  class DirectoryLoader
    def self.load(options)
      puts 'Using Directory Loader' if options[:verbose]

      service_definitions = []

      Dir.foreach(options[:directory]) do |f|
        next if File.directory?(f)

        puts "Loading definition #{f}" if options[:verbose]
        begin
          service_definitions << Servitude::ServiceDefinition.from(YAML.load_file(File.join(options[:directory], f)))
        rescue
          puts "Failed to load #{f}.  Trying the rest."
        end
      end

      puts "Loaded #{service_definitions.size} service definitions" if options[:verbose]

      service_definitions
    end
  end
end
