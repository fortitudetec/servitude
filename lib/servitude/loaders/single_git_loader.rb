require 'fileutils'
require 'servitude/service_definition'
require 'servitude/loaders/directory_loader'

module Servitude
  class SingleGitLoader
    def self.load(options)
      puts 'Using Single Git Loader' if options[:verbose]
      puts "Pulling git repository of definitions from #{options[:single]}" if options[:verbose]

      service_definitions = []
      begin
        # Make temp directory
        Dir.mkdir('.servitude')

        # Clone repo
        `git clone #{options[:single]} .servitude`

        # run Directory loader
        service_definitions = Servitude::DirectoryLoader.load(directory: '.servitude', verbose: options[:verbose])
      ensure
        FileUtils.rm_rf('.servitude')
      end

      service_definitions
    end
  end
end
