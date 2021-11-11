class Player 
    include UI

    def initialize
        @name = name 
    end

    def set_name
        puts "What is you name?\n\n"
        handle_long_input
    end



    attr_reader :name 
end