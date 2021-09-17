class HumanPlayer

    attr_accessor :mark, :name
    
    def initialize
        @name = nil
        @mark = nil
    end

    def get_position(legal_positions)
        puts "#{@name}, where do you want to place your #{@mark} ?"
         checker = false
        while checker == false
            puts "Type out the coordinates as two numbers with a space between them e.g. '0 2' "
            position = gets.chop.split(" ").map!(&:to_i)
            if legal_positions.include?(position)
                checker = true
            else
                puts "--------------------------------------------------"
                puts "Oops, try an empty position that's on the board."
            end
        end
        position
    end

end