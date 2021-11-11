# frozen_string_literal: true

class Game
  def initialize(story)
    @story = story
  end

  def start
    story.start
  end

  private

  attr_reader :story
end
