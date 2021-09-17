class Board

    attr_reader :grid

    def initialize(n=3)
        @n = n
        @grid = Array.new(n) {Array.new(n,'_')}
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

    def print_grid
        # @grid.each do |row|
        #     p row
        # end

        # Making the hash for use in laying out the grid
        i = 0
        hash = {}
        @grid.each do |row|
            row.each do |ele|
                if ele == '_'
                    hash[i] = " "
                else
                    hash[i] = ele
                end
                i += 1
            end
        end

        # Making the grid
        j = 0 #used to access the values stored in hash
        (@n-1).times do

            puts "     |" * (@n-1) + "     "

            (@n-1).times do
                print "  #{hash[j]}  |"
                j += 1
            end
                print "  #{hash[j]}  \n"
                j += 1

            puts "_____|" * (@n-1) + "_____"

        end

        puts "     |" * (@n-1) + "     "

        (@n-1).times do
            print "  #{hash[j]}  |"
            j += 1
        end
            print "  #{hash[j]}  \n"
            j += 1
            
        puts "     |" * (@n-1) + "     "

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


# puts "     |     |     "
# puts "     |     |     "
# puts "_____|_____|_____"
# puts "     |     |     "
# puts "     |  X  |     "
# puts "_____|_____|_____"
# puts "     |     |     "
# puts "     |     |     "
# puts "     |     |     "

# def print_grid(n)
#     (n-1).times do |y|
#         puts "     |" * (n-1) + "     "
#         puts "     |" * (n-1) + "     "
#         puts "_____|" * (n-1) + "_____"
#     end
#     puts "     |" * (n-1) + "     "
#     puts "     |" * (n-1) + "     "
#     puts "     |" * (n-1) + "     "
# end