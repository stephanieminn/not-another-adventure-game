# frozen_string_literal: true

require_relative "../ui"

class Game
  include UI

  def initialize(story)
    @story = story
  end

  def start
    puts "======================= STORY: #{story.title} =======================\n\n"

    start_node = nodes["1"]
    if start_node.nil?
      puts "Exiting -- can't find start node with key '1'."
      exit
    end

    progress(start_node)
  end

  private

  attr_reader :story

  def nodes
    story.nodes
  end

  def progress(node)
    if node.nil?
      puts "Exiting -- can't find node."
      exit
    end

    puts "#{node['text']}\n"
    finish if node["finish"]

    if non_branching?(node)
      handle_non_branching(node)
    else
      handle_branching(node)
    end
  end

  def finish
    puts "\n======================= THE END =======================\n\n"
    exit
  end

  def non_branching?(node)
    # Assumes no branching paths if the current node has a top level 'next_node'
    node["next_node"]
  end

  def handle_non_branching(node)
    next_node_key = node["next_node"]
    next_node = nodes[next_node_key]
    progress(next_node)
  end

  def handle_branching(node)
    branches = node["branches"]
    puts "What do you do?\n\n"
    branches.each do |branch|
      puts branch["text"]
    end

    selection = handle_input(branches)
    next_node_key = node["branches"][selection.to_i - 1]["next_node"]
    next_node = nodes[next_node_key] unless next_node_key.nil?
    progress(next_node)
  end
end
