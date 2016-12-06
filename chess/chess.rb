require_relative 'board.rb'
require_relative 'player.rb'
require_relative 'display.rb'
require 'byebug'
class Chess
  def initialize(name1, name2)
    @board = Board.new
    @player1 = Player.new(name1, :white)
    @player2 = Player.new(name2, :white)
    @current_player = @player1
    @board.populate
    @display = Display.new(@board)
    @display.render
  end

  def play
    until @board.checkmate?(@current_player.color)
      player_move
      switch_players
    end
    puts "#{@current_player.name} is the winner!"
  end

  def player_move
    puts "Enter start position #{@current_player.name}"
    from_move = @display.get_move(@current_player.color)
    piece = @board[from_move]

    puts "Enter where the piece should go"
    to_move = @display.get_move
    until piece.valid_moves.include?(to_move)
      puts "Invalid move!"
      to_move = @display.get_move
    end

    @board.update_position(piece, to_move)
    system("clear")
    @display.render
  end

  def switch_players
    @current_player = (@current_player == @player1 ? @player2 : @player1)
  end

end

chess = Chess.new("Shaurya", "Jessica")
chess.play

# color all the possible moves
# white should only chose white pieces
# check functionality for when piece has no other moves left
