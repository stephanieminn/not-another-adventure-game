# frozen_string_literal: true

class Node
  include UI

  def initialize(body)
    @body = body
  end

  def progress
    puts "#{body['text']}\n"
    finish if body["finish"]

    if non_branching?
      handle_non_branching
    else
      handle_branching
    end
  end

  private

  attr_reader :body

  def finish
    puts "\n======================= THE END =======================\n\n"
    exit
  end

  def non_branching?
    # Assumes no branching paths if the current node has a top level 'next_node'
    body["next_node"]
  end

  def handle_non_branching
    handle_input # Expects user to input anything to continue
    next_node_key = body["next_node"]
    next_node_key
  end

  def handle_branching
    branches = body["branches"]
    puts "What do you do?\n\n"
    branches.each do |branch|
      puts branch["text"]
    end

    selection = handle_input(branches)
    next_node_key = body["branches"][selection.to_i - 1]["next_node"]
    next_node_key
  end
end
