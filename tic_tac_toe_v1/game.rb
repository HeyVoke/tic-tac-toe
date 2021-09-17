require_relative "./board.rb"
require_relative "./human_player.rb"

class Game

    def initialize
        @player_1 = HumanPlayer.new
        @player_2 = HumanPlayer.new

        puts "Player 1, what is your name?"
        @player_1.name = gets.chop.capitalize
        puts "--------------------------------------------------"
        puts "Hello #{@player_1.name}! Would you like to be noughts or crosses?"
        
        valid = false
        while valid == false
            puts "Type x or o"
            input = gets.chop.upcase

            if input == "X"
                @player_1.mark = :X
                @player_2.mark = :O
                valid = true
            elsif input == "O"
                @player_1.mark = :O
                @player_2.mark = :X
                valid = true
            else
                puts "--------------------------------------------------"
                puts "Oops! That's not a valid choice :("
                puts "Let's try that again"
            end
        end
        puts "Great! You'll be playing as #{@player_1.mark}!"

        puts "--------------------------------------------------"  
        puts "Player 2, what is your name?"
        @player_2.name = gets.chop.capitalize
        puts "Hi #{@player_2.name}! You'll be playing as #{@player_2.mark}!"
        
        @current_player = @player_1
        @board = Board.new
        puts "--------------------------------------------------"
        @board.print
    end

    def switch_turn
        if @current_player == @player_1
            @current_player = @player_2
        else
            @current_player = @player_1
        end
    end

    def play
        finished = false
        while @board.empty_positions? && finished == false
            
            checker = false
            while checker == false
                position = @current_player.get_position
                if @board.valid?(position) && @board.empty?(position)
                    @board.place_mark(position, @current_player.mark)
                    checker = true
                else
                    puts "--------------------------------------------------"
                    puts "Oops, try an empty position that's on the board."
                end
            end
            @board.print
            puts "--------------------------------------------------"
            if @board.win?(@current_player.mark)
                self.congratulations 
                finished = true
            else
                self.switch_turn
            end
        end
        
        self.draw if finished == false
    end

    def congratulations
        puts "woohoo! You win! Congratulations #{@current_player.name}!"
    end

    def draw
        puts "It's a tie!"
    end

end

red = Game.new
red.play