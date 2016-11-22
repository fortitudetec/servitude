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
        puts def_file
        service_definitions << Servitude::ServiceDefinition.from(YAML.load_file(File.join(def_file)))
      end

    ensure
      FileUtils.rm_r('.servitude')
    end

      service_definitions
    end
  end
end
