# frozen_string_literal: true

class Story
  def self.available_stories
    files = Dir["./data/*.json"]
    files.map do |file|
      Story.new(File.basename(file, ".*"), create_nodes(file))
    end
  end

  def self.create_nodes(file)
    parsed_nodes = JSON.parse(File.read(file))
    parsed_nodes.transform_values! do |body|
      Node.new(body)
    end
  end

  def initialize(title, nodes)
    @title = title
    @nodes = nodes
  end

  attr_reader :title, :nodes
end
