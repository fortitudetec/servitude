require 'yaml'
require 'fileutils'
require 'sprawl/service_definition'

module Sprawl
  class MultiGitLoader
    def self.load(options)
      puts 'Using Multi Git Loader' if options[:verbose]

      begin
        # Make temp directory
        Dir.mkdir('.sprawl')

        pull_repos(options[:group])

        service_definitions = []

        Dir.glob('.sprawl/**/SPRAWL').each do |def_file|
          puts "Loading definition #{def_file}" if options[:verbose]

          begin
            service_definitions << Sprawl::ServiceDefinition.from(YAML.load_file(File.join(def_file)))
          rescue
            puts "Failed to load #{def_file}.  Trying the rest."
          end
        end
      ensure
        FileUtils.rm_rf('.sprawl')
      end

      service_definitions
    end

    def pull_repos(urls)
      urls.each do |url|
        puts "Pulling git repository of definitions from #{url}" if options[:verbose]
        Dir.chdir('.servitude') do
          `git clone #{url}`
        end
      end
    end
  end
end
