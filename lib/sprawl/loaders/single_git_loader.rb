require 'fileutils'
require 'sprawl/service_definition'
require 'sprawl/loaders/directory_loader'

module Sprawl
  class SingleGitLoader
    def self.load(options)
      puts 'Using Single Git Loader' if options[:verbose]
      puts "Pulling git repository of definitions from #{options[:single]}" if options[:verbose]

      service_definitions = []
      begin
        # Make temp directory
        Dir.mkdir('.sprawl')

        # Clone repo
        `git clone #{options[:single]} .sprawl`

        # run Directory loader
        service_definitions = Sprawl::DirectoryLoader.load(directory: '.sprawl', verbose: options[:verbose])
      ensure
        FileUtils.rm_rf('.sprawl')
      end

      service_definitions
    end
  end
end
