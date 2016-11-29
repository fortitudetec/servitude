require 'ruby-graphviz'

module Servitude
  class GraphvizDrawer
    def self.draw(defs, output)
      graph = ::GraphViz.new(:G, type: :digraph)

      nodes = generate_nodesgraph(graph, defs)

      # Generate the edges
      defs.each do |d|
        add_rest_connections(graph, nodes, d)
        add_async_connections(graph, nodes, d)
      end

      graph.output(svg: 'graph.svg') if output.casecmp('SVG').zero?
      graph.output(png: 'graph.png') if output.casecmp('PNG').zero?
    end

    private

    def generate_nodes(graph, defs)
      nodes = {}

      defs.each do |d|
        nodes[d.name] = graph.add_nodes(d.name)
      end

      nodes
    end

    def add_rest_connections(graph, nodes, service)
      return if service.rest_dependencies.nil?

      service.rest_dependencies.each do |r|
        graph.add_edges(nodes[service.name], nodes[r])
      end
    end

    def add_async_connections(graph, nodes, service)
      next if service.message_types_produced.nil?

      service.message_types_produced.each do |t|
        defs_consuming = defs.reject do |consuming_def|
          consuming_def.message_types_consumed.nil? || !consuming_def.message_types_consumed.include?(t)
        end

        defs_consuming.each do |c|
          graph.add_edges(nodes[service.name], nodes[c.name], style: 'dashed')
        end
      end
    end
  end
end
