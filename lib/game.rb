# frozen_string_literal: true

require "io/console"
require "json"
require "pry-byebug"
require_relative "./ui"
require_relative "./game/story"
require_relative "./game/game"
require_relative "./game/node"

module NotAnotherAdventureGame
  extend UI

  def self.run
    clear_screen
    puts "Hello! Welcome to Not Another Adventure Game. Press 'q' at any time to quit.\n\n"

    stories = Story.available_stories
    story = select_story(stories)
    Game.new(story).start
  end

  def self.select_story(stories)
    puts "Which story would you like to play? Press the corresponding number.\n\n"

    stories.each_with_index do |story, index|
      puts "[#{index + 1}] #{story.title}"
    end

    selection = handle_input(stories)
    stories[selection.to_i - 1]
  end
end

NotAnotherAdventureGame.run
