require 'debugger'
class Board
  attr_accessor :board
  def initialize(new_game = false)
    @board               = Array.new(9) {Array.new(9)}
    board_setup unless new_game 
  end

  def board_setup
    @board[0]            = [nil, "1", "2", "3", "4", "5", "6", "7", "8"]
    @board[1]            = [nil, 
      Rook.new(self,   [1, 1], "white"), 
      Knight.new(self, [1, 2], "white"), 
      Bishop.new(self, [1, 3], "white"), 
      Queen.new(self,  [1, 4], "white"), 
      King.new(self,   [1, 5], "white"), 
      Bishop.new(self, [1, 6], "white"), 
      Knight.new(self, [1, 7], "white"), 
      Rook.new(self,   [1, 8], "white")]
      for row in (3..6) do 
        @board[row]= Array.new(9) {[]}
      end
      @board[8]          = [nil, 
        Rook.new(self,   [8, 1], "black"), 
        Knight.new(self, [8, 2], "black"), 
        Bishop.new(self, [8, 3], "black"), 
        Queen.new(self,  [8, 4], "black"), 
        King.new(self,   [8, 5], "black"), 
        Bishop.new(self, [8, 6], "black"), 
        Knight.new(self, [8, 7], "black"), 
        Rook.new(self,   [8, 8], "black")]
        9.times do |col|
          @board[2][col] = Pawn.new(self, [2, col], "white")
          @board[7][col] = Pawn.new(self, [7, col], "black")
          @board[col][0] = (col).to_s + " " 
        end
        p @board[2][8]
      end
  
      def square(col, row)
        @board[row][col]
      end

    end
