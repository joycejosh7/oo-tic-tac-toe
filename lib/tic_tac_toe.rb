class TicTacToe
    def initialize
        @board = Array.new(9, " ")
    end
    
    WIN_COMBINATIONS = [
        [0, 1, 2], 
        [3, 4, 5], 
        [6, 7, 8],
        [0, 3, 6], 
        [1, 4, 7], 
        [2, 5, 8],
        [0, 4, 8], 
        [2, 4, 6]
    ]

    def display_board
        puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
        puts "-----------"
        puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
        puts "-----------"
        puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
    end

    def input_to_index(user_input)
        user_input.to_i - 1
    end

    def move(index, token)
        @board[index] = token
    end

    def position_taken?(index)
        @board[index] != " "
    end

    def valid_move?(index)
        !position_taken?(index) && index.between?(0,8)
    end

    def turn_count
        @board.count{|square| square != " " }
    end

    def current_player
        turn_count.even? ? "X" : "O"
    end

    def turn
        print "Please enter a number (1-9):"
        user_input = gets.strip
        index = input_to_index(user_input)
        if valid_move?(index)
          move(index, current_player)
          display_board
        else
        puts "Invalid choice, please try again"
        turn
        end
    end

    def won?
        WIN_COMBINATIONS.any? do |combo|
          if position_taken?(combo[0]) && @board[combo[0]] == @board[combo[1]] && @board[combo[1]] == @board[combo[2]]
            return combo
          end
        end
    end  

    def full?
        @board.none? {|position| position == " "}
    end

    def draw?
        full? && !won?
    end

    def over?
        won? || draw?
    end

    def winner
        if win_combo = won?
            @board[win_combo[0]]
        end
    end

    def play
        puts "Welcome to Tic Tac Toe!"
        display_board
        until over?
            turn
        end
        if draw?
            puts "Cat's Game!"
        else
            puts "Congratulations #{winner}!"
        end
    end
end
