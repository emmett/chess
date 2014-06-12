# -*- coding: UTF-8 -*-
require 'debugger'
class Piece 
  DIAGONALS = [[1, 1],[1, -1], [-1, 1], [-1, -1]]
  STRAIGHTS = [[1, 0], [0, 1], [-1, 0], [0, -1]]
  VALID_SQUARES = (1..8).to_a.product((1..8).to_a) 
  
  attr_reader :char, :color
  attr_accessor :pos
  
  def initialize(board, pos, color)
    @board, @pos, @color = board, pos, color

  end
    
  def empty?
    false
  end
  
  def on_board?(loc)
    Piece::VALID_SQUARES.include?(loc)
  end
  
  def open?(loc)
    on_board?(loc) && @board.board[loc[0]][loc[1]].nil?
  end
  
  def capture?(loc)
    if on_board?(loc) && @board.board[loc[0]][loc[1]].nil?
      return false
    else
      !open?(loc) && on_board?(loc) && @board.board[loc[0]][loc[1]].color != @color 
    end
  end
  
  def valid_moves
    self.moves.reject { |move| causes_check? move }
  end
  
  def causes_check? (end_pos)
    test_board = @board.dup
    test_board.move!(self.pos, end_pos)
    test_board.in_check?(self.color)
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
    possible_moves
  end
end


class Bishop < Piece
  def move_dirs
    Piece::DIAGONALS
  end
  def to_s
    self.color == "white" ? "♗": "♝"
  end
end
  

class King < Piece
  def move_dirs
    Piece::DIAGONALS + Piece::STRAIGHTS
  end
  
  def to_s
    self.color == "white" ? "♔": "♚"
  end

  def moves
    possible_moves = []
    self.move_dirs.each do |delta|
      new_loc = [@pos[0] + delta[0], @pos[1] + delta[1]]
      if on_board?(new_loc) && (open?(new_loc) || capture?(new_loc))
        possible_moves << new_loc 
      end
    end
    return possible_moves
  end
end    


class Queen < Piece
  def move_dirs
    Piece::DIAGONALS + Piece::STRAIGHTS
  end
  def to_s
    self.color == "white" ? "♕": "♛"
  end
end


class Rook < Piece
  def move_dirs
    Piece::STRAIGHTS
  end
  
  def to_s
    self.color == "white" ? "♖": "♜"
  end
end

class Knight < Piece   #also a horse...........☐☐
  def to_s
    self.color == "white" ? "♘": "♞"
  end
  
  def moves
    dxdy = (-2..2).to_a.product((-2..2).to_a)
    dxdy = dxdy.select { |pos| pos[0].abs + pos[1].abs == 3 } 
    possible_positions = dxdy.map { |pos| [pos[0] + @pos[0], pos[1] + @pos[1]] }
    possible_positions.select do |tile| 
      on_board?(tile) && (open?(tile) || capture?(tile)) 
    end
  end
end

class Pawn < Piece
  def to_s
    self.color == "white" ? "♙": "♟"
  end

  def moves
    row = pos[0]
    col = pos[1]
    possible_moves = []
    
    if color == "black"
      hasnt_moved = row == 7
      direction = -1
    else
      hasnt_moved = row == 2
      direction = 1
    end
    
    first_step = [row + direction, col]
    if open? first_step
      possible_moves << first_step
      second_step = [row + (2 * direction), col]
      if open? second_step && hasnt_moved
        possible_moves << second_step
      end
    end
    
    maybe_captures = [[row + direction, col + 1],[row + direction, col - 1]]
    
    possible_moves + maybe_captures.select{ |pos| capture?(pos) }
  end
end
