# frozen_string_literal: true

require_relative "../ui"

class Story
  def self.available_stories
    files = Dir["./data/*.json"]
    files.map do |file|
      Story.new(File.basename(file, ".*"), parse(file))
    end
  end

  def self.parse(file)
    JSON.parse(File.read(file))
  end

  def initialize(title, nodes)
    @title = title
    @nodes = nodes
  end

  attr_reader :title, :nodes
end
