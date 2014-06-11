#!/usr/bin/env ruby
# -*- coding: UTF-8 -*-
load './board.rb'
load './pieces.rb'
require 'debugger'

class Game
  def initialize
    @gameboard = Board.new
    @x = 1
    @y = 1
    play
  end
    
  def display
    system("clear")
    @gameboard.board.each_with_index do |row, y1|
      line = ""
      row.each_with_index do |tile, x1|
        contents = @gameboard.square(x1, y1)
        if x1 == 0 || y1 == 0
          space = contents
        elsif contents.empty?
          space = "☐"
        else
          space = contents.char
        end
        if x1 == @x && y1 == @y 
          space = " " + space
        else
          space = space + " " 
        end
        line << space
      end  
      puts line
    end
    p"#{@x}, #{@y}"
  end
  
  def cursor 
    display
    begin
      system("stty raw -echo")
      input = STDIN.getc.chr
      if input == "\e" then
        input << STDIN.read_nonblock(3) rescue nil
        input << STDIN.read_nonblock(2) rescue nil
      end
    ensure
      system("stty -raw echo")
    end
    case input
    when "\e[D"
      @x == 1 ? @x = 8 : @x -= 1 
    when "\e[B"
      @y == 8 ? @y = 1 : @y += 1 
    when "\e[C"
      @x == 8 ? @x = 1 : @x += 1 
    when "\e[A"
      @y == 1 ? @y = 8 : @y -= 1 
    when "f"
      return "F"
    when "\r"
      return "R" unless @gameboard.square(@x, @y).moves.empty?
      cursor
    when "\e"
      return "c"
    end
    cursor
  end
  
  
  def won?
    false
  end
  
  def play
    until won?
      action = cursor
      case action
      when "F"
        puts "move char"
      when "R"
        p "please select your end coordinates"
        p @gameboard.square(@x, @y).moves
        loc = [0,0]
        until @gameboard.square(@x, @y).moves.include?([loc[0], loc[1]])
          display
          p "please select your end coordinates"
          p @gameboard.square(@x, @y).moves
          loc = gets.chomp.reverse
        end
        swap_positions(@gameboard.square(@x, @y), loc)
      when "c"
        return         
      end      
    end
  end
  
  def swap_positions(piece1, loc)
    @gameboard.board[loc[0]][loc[1]], piece1.pos = piece1, loc
    piece1 = []
    puts "swapped"
  end
  
  # def capture(piece1, piece2)
#     piece1, piece2, piece1.pos = piece2, [], piece2.pos
#   end
end