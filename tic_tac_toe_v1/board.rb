class Board

    def initialize
        @grid = Array.new(3) {Array.new(3,'_')}
    end

    def valid?(position) # position is an array e.g. [0, 1]
        return false if position.any? { |num| num.is_a?(String) || num == nil || num.to_i < 0 }
        position[0] < @grid.length && position[1] < @grid[0].length
    end

    def empty?(position)
        @grid[position[0]][position[1]] == '_'
    end

    def place_mark(position, mark)
            if self.valid?(position) && self.empty?(position)
                @grid[position[0]][position[1]] = mark
            end
    end

    def print
        # @grid.each do |row|
        #     p row
        # end
        def contents(position)
            return " " if @grid[position[0]][position[1]] == '_'
            @grid[position[0]][position[1]]
        end

        puts "     |     |     "
        puts "  #{contents([0,0])}  |  #{contents([1,0])}  |  #{contents([2,0])}  "
        puts "_____|_____|_____"
        puts "     |     |     "
        puts "  #{contents([0,1])}  |  #{contents([1,1])}  |  #{contents([2,1])}  "
        puts "_____|_____|_____"
        puts "     |     |     "
        puts "  #{contents([0,2])}  |  #{contents([1,2])}  |  #{contents([2,2])}  "
        puts "     |     |     "
    end

    def empty_positions? # return a boolean indicating whether or not there is at least one empty position on the grid.
        !@grid.all? { |row| row.all? { |ele| ele != '_' } }
    end

    def win_row?(mark)
        @grid.any? { |row| row.all? { |ele| ele == mark } }
    end

    def win_col?(mark)
       (0...@grid.length).each do |i|
        return true if @grid.all? { |row| row[i] == mark }
       end
       false
    end

    def win_diagonal?(mark)
        positive = true
        negative = true
        (0...@grid.length).each do |i|
            j = @grid.length - 1 - i
            positive = false if @grid[i][i] != mark
            negative = false if @grid[i][j] != mark
        end
        return positive || negative
    end

    def win?(mark)
        win_row?(mark) || win_col?(mark) || win_diagonal?(mark)
    end

end
