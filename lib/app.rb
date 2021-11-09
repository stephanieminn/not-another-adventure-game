# frozen_string_literal: true

require "io/console"
require "json"
require "pry"
require_relative "./ui"
require_relative "./game/story"
require_relative "./game/game"

class App
  extend UI

  def self.run
    clear_screen
    puts "Hello! Welcome to The Game. It's starting now. Press 'q' at any time to quit.\n\n"

    story = Story.select
    exit if story.nil?

    Game.new(story).start
  end
end

App.run