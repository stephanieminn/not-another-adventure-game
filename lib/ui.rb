# frozen_string_literal: true

module UI
  def clear_screen
    puts "\e[H\e[2J"
  end

  def prompt
    $stdout.write ">> "
    $stdin.getch
  end

  def quit?(input)
    return false unless input == "q"

    puts "Hmm, I see you've decided to quit. Until next time."
    true
  end

  def enter?(input)
    input.strip == ""
  end

  def valid?(input, options)
    return true if input.to_i.between?(1, options.size)

    puts "Sorry, that's not a valid input.\n\n"
    false
  end
end
