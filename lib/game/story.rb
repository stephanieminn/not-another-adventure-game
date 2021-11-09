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

      return Story.new(parse(files.sample)) if enter?(input)
      return Story.new(parse(files[input.to_i - 1])) if valid?(input, files)
    end
  end

  def self.parse(file)
    JSON.parse(File.read(file))
  end

  def initialize(nodes)
    @nodes = nodes
  end

  attr_reader :nodes
end
