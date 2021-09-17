class HumanPlayer

    attr_accessor :mark, :name
    
    def initialize
        @name = nil
        @mark = nil
    end

    def get_position
        puts "#{@name}, where do you want to place your #{@mark} ?"
        puts "Type out the coordinates as two numbers with a space between them e.g. '0 2' "
        position = gets.chop.split(" ").map!(&:to_i)
    end

end