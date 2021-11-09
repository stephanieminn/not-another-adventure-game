# frozen_string_literal: true

require_relative "../ui"

class Story
  extend UI

  def self.select
    puts "Which story would you like to play? Press the corresponding number, or hit enter for a random story.\n\n"
    files = Dir["./data/*.json"]
    files.each_with_index do |file, index|
      puts "[#{index + 1}] #{File.basename(file)}"
    end

    while (code = prompt)
      input = code.strip
      puts "#{input}\n\n"
      exit if quit?(input)

      if enter?(input)
        file = files.sample
        return Story.new(File.basename(file, ".*"), parse(file))
      end

      if valid?(input, files)
        file = files[input.to_i - 1]
        return Story.new(File.basename(file, ".*"), parse(file))
      end
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
