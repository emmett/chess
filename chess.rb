#!/usr/bin/env ruby
# -*- coding: UTF-8 -*-
load './board.rb'
load './pieces.rb'


class Game
    
  def initialize
    @gameboard = Board.new
    play
  end
    
  def display
    puts "\e[H\e[2J"
    @gameboard.board.reverse.each do |row|
      row.map do |col|
        case col
        when nil
          print "[]"
        when Piece
          print col.char
        else
          print col
        end
      end
      puts
    end
    # puts image
  end
  
  def won?
    false
  end
  
  def stalemate?
  end
  
  def play
    until won? || stalemate?
      display
      puts " please enter start coordinates for the piece"
      start_pos = gets.chomp
      start_x, start_y = start_pos[0].to_i, start_pos[1].to_i
      p start_x
      p start_y
      p @gameboard.square(start_x, start_y).moves
      gets.chomp
    end
  end
  
end

