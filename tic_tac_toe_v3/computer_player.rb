class ComputerPlayer

    attr_accessor :mark, :name
    
    def initialize(name, mark)
        @name = name
        @mark = mark
    end

    def get_position(legal_positions)
        puts "#{@name} took their turn!"
        i = rand(0...legal_positions.length)
        legal_positions[i]
    end

end