require_relative "./board.rb"
require_relative "./human_player.rb"

class Game

    def initialize
        @n = 3
        get_grid_size
        @players = {}
        get_players
        @current_player = @players[0]
        @board = Board.new(@n)
        @board.print_grid
    end

    def get_grid_size
        puts "what size grid would you like? Type a number then press enter"
        @n = gets.chop.to_i
    end

    def get_players
        puts "how many human players are there?"
        puts "Type a number then press enter"
        x = gets.chop.to_i
        (0...x).each do |i|
            @players[i] = HumanPlayer.new
            puts "Player #{i + 1}, what is your name?"
            @players[i].name = gets.chop.capitalize
            puts "--------------------------------------------------"
            puts "Hello #{@players[i].name}! What symbol would you like to use?"
            valid = false
            while valid == false
            puts "Please type a single letter then press enter"
                ans = gets.chop
                if @players.values.any? { |instance| instance.mark == ans} || ans.length != 1
                    puts "--------------------------------------------------"
                    puts "Oops! That's not a valid choice :("
                    puts "Let's try that again"
                else
                    @players[i].mark = ans.upcase.to_sym
                    puts "Great! You'll be playing as #{@players[i].mark}!"
                    puts "--------------------------------------------------"
                    valid = true
                end
            end
        end  
    end

    def switch_turn
        turn = @players.key(@current_player)
        turn += 1
        turn = 0 if turn > @players.length - 1
        @current_player = @players[turn]
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
            @board.print_grid
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