require_relative "./board.rb"
require_relative "./human_player.rb"
require_relative "./computer_player.rb"

class Game

    def initialize
        @n = 3
        get_grid_size
        @players = {}
        get_players
        @current_player = @players[0]
        @board = Board.new(@n)
        @board.print_grid
        puts "--------------------------------------------------"
    end

    def get_grid_size
        puts "what size grid would you like? Type a number then press enter"
        @n = gets.chop.to_i
    end

    def get_players
        puts "--------------------------------------------------"
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
        puts "--------------------------------------------------"
        puts "how many computer players would you like?"
        puts "Type a number then press enter"
        y = gets.chop.to_i
        (0...y).each do |j|
            comp_mark = get_computer_mark
            comp_name = "Computer #{j+1}"
            puts "Say hello to computer player #{j+1}, they'll be playing as #{comp_mark}"
            @players[x+j] = ComputerPlayer.new(comp_name, comp_mark)
            puts "--------------------------------------------------"
        end
        
    end

    def get_computer_mark
        range = ["x","o"] + ("a".."z").to_a
        range.map! { |char| char.upcase.to_sym }
        range.each { |char| return char if @players.values.none? { |player| player.mark == char }}
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
            position = @current_player.get_position(@board.legal_positions)
            @board.place_mark(position, @current_player.mark)
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