# frozen_string_literal: true

class Story
  def self.available_stories
    files = Dir["./data/*.json"]
    files.map do |file|
      Story.new(file)
    end
  end

  def initialize(file)
    @title = File.basename(file, ".*")
    @nodes = nodes_from_file(file)
  end

  def start
    puts "======================= STORY: #{title} =======================\n\n"

    start_node = nodes["1"]
    next_node = start_node.progress

    next_node = next_node.progress while next_node

    puts "Exiting -- can't find node."
    exit
  end

  attr_reader :title, :nodes

  private

  def nodes_from_file(file)
    data = JSON.parse(File.read(file))
    data.transform_values! do |value|
      Node.new(value, self)
    end
  end
end
