# frozen_string_literal: true

require_relative "../ui"

class Game
  def initialize(story)
    @story = story
  end

  def start
    puts "======================= STORY: #{story.title} =======================\n\n"

    start_node = nodes["1"]
    next_node_key = start_node.progress

    while next_node_key
      next_node = nodes[next_node_key]
      next_node_key = next_node.progress
    end
  end

  private

  attr_reader :story

  def nodes
    story.nodes
  end
end
