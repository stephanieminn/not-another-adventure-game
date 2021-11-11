# frozen_string_literal: true

class Node
  include UI

  def initialize(data, story)
    @data = data
    @story = story
  end

  def progress
    puts "#{data['text']}\n"
    finish if data["finish"]

    if non_branching?
      handle_non_branching
    else
      handle_branching
    end
  end

  private

  attr_reader :data, :story

  def finish
    puts "\n======================= THE END =======================\n\n"
    exit
  end

  def non_branching?
    # Assumes no branching paths if the current node has a top level 'next_node'
    data["next_node"]
  end

  def handle_non_branching
    handle_input # Expects user to input anything to continue
    next_node_key = data["next_node"]
    story.nodes[next_node_key]
  end

  def handle_branching
    branches = data["branches"]
    puts "What do you do?\n\n"
    branches.each do |branch|
      puts branch["text"]
    end

    selection = handle_input(branches)
    next_node_key = data["branches"][selection.to_i - 1]["next_node"]
    story.nodes[next_node_key]
  end
end
