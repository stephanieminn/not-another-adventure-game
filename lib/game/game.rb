# frozen_string_literal: true

require_relative "../ui"

class Game
  include UI

  def initialize(story)
    @story = story
  end

  def start
    puts "======================= STORY: #{story.title} =======================\n\n"

    current_node = nodes["1"]
    if current_node.nil?
      puts "Exiting -- can't find start node with key '1'."
      exit
    end

    progress(current_node)

    while (code = prompt)
      input = code.strip
      puts "#{input}\n\n"
      exit if quit?(input)

      next_node_key = find_next_node(input, current_node)
      current_node = nodes[next_node_key] unless next_node_key.nil?
      progress(current_node)
    end
  end

  private

  attr_reader :story

  def nodes
    story.nodes
  end

  def progress(node)
    puts "#{node['text']}\n"
    if node["finish"]
      puts "\n======================= THE END =======================\n\n"
      exit
    end

    return if node["choices"].empty?

    puts "What do you do?\n\n"
    node["choices"].each do |choice|
      puts choice["text"]
    end
  end

  def find_next_node(input, current_node)
    if move_it_along?(current_node)
      current_node["next_node"]
    elsif valid?(input, current_node["choices"])
      current_node["choices"][input.to_i - 1]["next_node"]
    end
  end

  def move_it_along?(current_node)
    # If the current node has no branching paths, but has a next node and is not the end of the tree
    current_node["choices"].empty? && current_node["next_node"] && !current_node["finish"]
  end
end
