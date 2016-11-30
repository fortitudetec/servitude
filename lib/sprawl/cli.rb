require 'sprawl/version'
require 'sprawl/definition_loader'
require 'sprawl/drawers/graphviz_drawer'
require 'optparse'

module Sprawl
  class Cli
    def run
      options = parse_options
      defs = load_defs(options)

      # TODO: Probably want to allow for different rendering engines
      GraphvizDrawer.draw(defs, options[:output])
    end

    private

    def parse_options
      options = {}
      OptionParser.new do |opts|
        opts.banner = 'Usage: sprawl [options]'

        opts.on('-d DIRECTORY', '--directory=DIRECTORY', 'Locate definition files in given directory') do |d|
          options[:directory] = d
          options[:location_type] = :directory
        end

        opts.on('-g REPOSITORIES',
                '--group-of-repositories=REPOSITORIES',
                Array,
                'Locate definition files across many git repositories (SERVITUDE files)') do |g|
          options[:group] = g
          options[:location_type] = :group
        end

        opts.on('-h', '--help', 'Prints this help') do
          puts opts
          exit
        end

        opts.on('-o OUTPUTTYPE', '--output-type=OUTPUTTYPE', 'Format of output (SVG, PNG, Text, HTML)') do |o|
          options[:output] = o
        end

        opts.on('-s REPOSITORY',
                '--single-repository=REPOSITORY',
                'Locate all definition files in a single git repository') do |s|
          options[:single] = s
          options[:location_type] = :single
        end

        opts.on('-v', '--[no-]verbose', 'Runs verbosely') do |v|
          options[:verbose] = v
        end
      end.parse!
      options
    end

    def load_defs(options)
      DefinitionLoader.load(options)
    end
  end
end
