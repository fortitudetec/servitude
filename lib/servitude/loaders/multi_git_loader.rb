require 'yaml'
require 'fileutils'
require 'servitude/service_definition'

module Servitude
  class MultiGitLoader
    def self.load(options)
      puts 'Using Multi Git Loader' if options[:verbose]

      begin
        # Make temp directory
        Dir.mkdir('.servitude')
  
        options[:group].each do |url|
          puts "Pulling git repository of definitions from #{url}" if options[:verbose]
          Dir.chdir('.servitude') do
            `git clone #{url}`
          end
        end
  
        service_definitions = []
  
        Dir.glob('.servitude/**/SERVITUDE').each do |def_file|
          puts "Loading definition #{def_file}" if options[:verbose]
          
          begin
            service_definitions << Servitude::ServiceDefinition.from(YAML.load_file(File.join(def_file)))
          rescue
            puts "Failed to load #{def_file}.  Trying the rest."
          end
        end
      ensure
        FileUtils.rm_rf('.servitude')
      end

      service_definitions
    end
  end
end
