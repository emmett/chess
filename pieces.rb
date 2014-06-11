# -*- coding: UTF-8 -*-
class Tile
  attr_reader :pos, :char, :color
  
  def initialize(board, pos, color)
    @board, @pos, @color = board, pos, color
    @char = "☐ "
  end
end
class Piece
  PIECES = {
    "black" => { 
      King => "♚ ",
      Queen => "♛ ",
      Rook => "♜ ",
      Bishop => "♝ ",
      Knight => "♞ ",
      Pawn => "♟ " 
    },
  
    "white" => {
      King => "♔ ",
      Queen => "♕ ",
      Rook => "♖ ",
      Bishop => "♗ ",
      Knight => "♘ ",
      Pawn => "♙ " 
    },
  }
  DIAGONALS = [[1,1],[1, -1], [-1,1], [-1, -1]]
  STRAIGHTS = [[1,0], [0, 1], [-1, 0], [0, -1]]
  VALID_SQUARES = (1..8).to_a.product((1..8).to_a) 
  
  attr_reader :pos, :char, :color
  
  def initialize(board, pos, color)
    @board, @pos, @color = board, pos, color
    @char = PIECES[@color][self.class]
  end
  
  def on_board?(loc)
    Piece::VALID_SQUARES.include?(loc)
  end
  
  def open?(loc)
    @board.board[loc[0]][loc[1]].nil?
  end
  
  def capture?(loc)
    @board.board[loc[0]][loc[1]].color != @color if on_board?(loc)
  end
  
  def moves
    possible_moves = []
    self.move_dirs.each do |delta|
      new_loc = [@pos[0] + delta[0], @pos[1] + delta[1]]
      while on_board?(new_loc) && open?(new_loc)
        possible_moves << new_loc
        new_loc = [new_loc[0] + delta[0], new_loc[1] + delta[1]]
      end
      possible_moves << new_loc if capture?(new_loc)
    end
    return possible_moves
  end
end

 

class Bishop < Piece
  def move_dirs
    Piece::DIAGONALS
  end
end
  

class King < Piece
  
  def move_dirs
    Piece::DIAGONALS + Piece::STRAIGHTS
  end
  
  def moves
    possible_moves = []
    self.move_dirs.each do |delta|
      new_loc = [@pos[0] + delta[0], @pos[1] + delta[1]]
      
      possible_moves << new_loc if on_board && (open || capture?)
    end
    return possible_moves
  end
end    


class Queen < Piece
  def move_dirs
    Piece::DIAGONALS + Piece::STRAIGHTS
  end
end


class Rook < Piece
  def move_dirs
    Piece::STRAIGHTS
  end
end

class Knight < Piece   #also a horse
  # def moves
  #     dxdy = (-2..2).to_a.product((-2..2).to_a)
  #     dxdy = dxdy.select {|pos| pos[0].abs + pos[1].abs == 3} 
  #     possible_positions = dxdy.map {|pos| [pos[0] + @pos[0], pos[1] + @pos[1]]} 
  #     possible_positions.select{|tile| tile}
  #   # end
  # check if capture && in bounds
end

class Pawn < Piece
  # def moves
#     moves = []
#     if color == "black"   
#       if pos[0] == 7 
#         moves << [pos[0] -1, pos[1]]
#       else
#         moves << [pos[0] - 1, pos[1]]
#       end
#     # else
# #       if pos[0] == 7 
# #         moves << [pos[0] + 1, pos[1]], [pos[0] + 2, pos[1]]
# #       else
# #         moves << [pos[0] + 1, pos[1]]
# #       end
#     end
#     moves = moves.select {|m| on_board?(m) && open?(m)}
#     
#   end
end