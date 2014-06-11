# -*- coding: UTF-8 -*-

class Piece 
  DIAGONALS = [[1, 1],[1, -1], [-1, 1], [-1, -1]]
  STRAIGHTS = [[1, 0], [0, 1], [-1, 0], [0, -1]]
  VALID_SQUARES = (1..8).to_a.product((1..8).to_a) 
  
  attr_reader :char, :color
  attr_accessor :pos
  
  def initialize(board, pos, color)
    @board, @pos, @color = board, pos, color
    @char = CHARACTERS[@color][self.class]
  end
  
  def to_s
    @char
  end
  
  def empty?
    false
  end
  
  def on_board?(loc)
    Piece::VALID_SQUARES.include?(loc)
  end
  
  def open?(loc)
    on_board?(loc) && @board.board[loc[0]][loc[1]].empty?
  end
  
  def capture?(loc)
    if on_board?(loc) && @board.board[loc[0]][loc[1]].empty?
      return false
    else
      !open?(loc) && on_board?(loc) && @board.board[loc[0]][loc[1]].color != @color 
    end
  end
  
  def moves
    possible_moves = []
    move_dirs.each do |delta|
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
      possible_moves << new_loc if on_board?(new_loc) && (open?(new_loc) || capture?(new_loc))
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

class Knight < Piece   #also a horse...........☐☐
  def moves
      dxdy = (-2..2).to_a.product((-2..2).to_a)
      dxdy = dxdy.select {|pos| pos[0].abs + pos[1].abs == 3} 
      p dxdy
      possible_positions = dxdy.map {|pos| [pos[0] + @pos[0], pos[1] + @pos[1]]}
      move_list = possible_positions.select{|tile| open?(tile)}
      
      p move_list
    end
end

class Pawn < Piece
  def moves
    row = pos[0]
    col = pos[1]
    possible_moves = []
    if color == "black"   
      if pos[0] == 7 
        possible_moves << [row - 1, col] 
        possible_moves << [row - 2, col]
      else
        possible_moves << [row - 1, col]
      end
      possible_moves = possible_moves.select {|m| on_board?(m) && open?(m)}
      captures = [[row - 1, col + 1],[row - 1, col - 1]].select{|pos| capture?(pos)}
    else  
      if row == 2 
        possible_moves << [row + 1, col] 
        possible_moves << [row + 2, col]
      else
        possible_moves << [row + 1, col]
      end
      possible_moves = possible_moves.select {|m| on_board?(m) && open?(m)}
      captures = [[row + 1, col + 1],[row + 1, col - 1]].select{|pos| capture?(pos)}
    end
    possible_moves + captures
  end
end
CHARACTERS = { "black" => { 
    King => "♚",
    Queen => "♛",
    Rook => "♜",
    Bishop => "♝",
    Knight => "♞",
    Pawn => "♟"},
  "white" => {
    King => "♔",
    Queen => "♕",
    Rook => "♖",
    Bishop => "♗",
    Knight => "♘",
    Pawn => "♙"}
}