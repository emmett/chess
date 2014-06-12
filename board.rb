#!/usr/bin/env ruby
# -*- coding: UTF-8 -*-
class Board
  attr_accessor :board
  
  def initialize(new_game = false)
    @board = Array.new(9) {Array.new(9)}
    board_setup unless new_game 
  end
  
  # def square(col, row)
  #   @board[row][col]
  # end
  
 def display
   self.board.each_with_index do |row, y1|
     line = ""
     row.each_with_index do |tile, x1|
       if x1 == 0 || y1 == 0
         space = tile
       elsif tile.nil?
         space = "☐"
       else
         space = tile.to_s
       end
       #cursor stuff here
       # if x1 == @col && y1 == @row 
#          space = " " + space
#        else
#          space = space + " " 
#        end
       line << space
     end  
     puts line
   end
 end

  def dup
    dup_board = Board.new(true)
    self.board.each_with_index do |row, row_idx|
      row.each_with_index do |tile, tile_idx|
        if tile.is_a? Piece
          duped_piece = tile.class.new(dup_board, [row_idx, tile_idx], tile.color)
          dup_board.board[row_idx][tile_idx] = duped_piece 
        end
      end
    end
    dup_board
  end
  
  def move(start, end_pos)#these are arrays are in ROW,COL format
    piece_to_move = @board[start[0]][start[1]]
    raise "not a piece" unless piece_to_move.is_a? Piece
    raise "not valid" unless piece_to_move.valid_moves.include?(end_pos)
    move!(start, end_pos)
  end
  
  def move!(start, end_pos)
    piece_to_move = self.board[start[0]][start[1]]
    raise "this should never be nill" if piece_to_move.nil?
    @board[start[0]][start[1]] = nil
    @board[end_pos[0]][end_pos[1]] = piece_to_move
    piece_to_move.pos = end_pos
  end
  
  def get_pieces(color)
    pieces = self.board.flatten.compact
    pieces = pieces.select{ |piece| piece.is_a? Piece }
    pieces.select{ |piece| piece.color == color }
  end
  
  def king_positions
    hash = {} 
    kings = self.board.flatten.compact.select{|piece| piece.class == King}
    kings.each do |k|
      hash[k.color] = k.pos
    end
    return hash
  end  
  
  def in_check?(color)
    color == "black" ? enemy = "white" : enemy = "black"
    king_pos = king_positions[color]
    pieces = get_pieces(enemy)
    return (pieces.any? {|piece| piece.moves.include?(king_pos)})
  end
  
  private
  
  def board_setup
    @board[0] = [nil, "1", "2", "3", "4", "5", "6", "7", "8"]
    @board[1] = [
      nil, 
      Rook.new(self,   [1, 1], "white"), 
      Knight.new(self, [1, 2], "white"), 
      Bishop.new(self, [1, 3], "white"), 
      Queen.new(self,  [1, 4], "white"), 
      King.new(self,   [1, 5], "white"), 
      Bishop.new(self, [1, 6], "white"), 
      Knight.new(self, [1, 7], "white"), 
      Rook.new(self,   [1, 8], "white")
    ]
    
    # for row in (3..6) do 
    #   @board[row]= Array.new(9) {[]}
    # end
    # 
    @board[8] = [
      nil, 
      Rook.new(self,   [8, 1], "black"), 
      Knight.new(self, [8, 2], "black"), 
      Bishop.new(self, [8, 3], "black"), 
      Queen.new(self,  [8, 4], "black"), 
      King.new(self,   [8, 5], "black"), 
      Bishop.new(self, [8, 6], "black"), 
      Knight.new(self, [8, 7], "black"), 
      Rook.new(self,   [8, 8], "black")
    ]
    9.times do |col|
      @board[2][col] = Pawn.new(self, [2, col], "white")
      @board[7][col] = Pawn.new(self, [7, col], "black")
      @board[col][0] = (col).to_s + " " 
    end
  end

end