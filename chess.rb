#!/usr/bin/env ruby
# -*- coding: UTF-8 -*-
load './board.rb'
load './pieces.rb'
require 'debugger'

class Game
  def initialize
    @gameboard = Board.new()
    @col = 1
    @row = 1
    play
  end
  
  def play
    turn = "white"
    loop do
      @gameboard.display
      start_pos = get_input("start", turn)
      end_pos = get_input("end", turn)
      @gameboard.move(start_pos, end_pos, turn)
      turn == "white" ? turn = "black" : turn = "white"
    end 
  end
  
  def get_input(type, turn)
      puts "#{turn} player's turn"
      puts "please enter #{type} (x,y)"
      pos_string = gets.chomp
      pos = pos_string.split(',').reverse.map(&:to_i)
    end
  end
  # turn logic
  # end game logic
  # set to valid moves
  #
  


# def display
#     system("clear")
#     @gameboard.board.each_with_index do |row, y1|
#       line = ""
#       row.each_with_index do |tile, x1|
#         contents = @gameboard.square(x1, y1)
#         if x1 == 0 || y1 == 0
#           space = contents
#         elsif contents.empty?
#           space = "☐"
#         else
#           space = contents.to_s
#         end
#         if x1 == @col && y1 == @row 
#           space = " " + space
#         else
#           space = space + " " 
#         end
#         line << space
#       end  
#       puts line
#     end
#     # p"#{@row}, #{@col}"
#     # p "#{@turn}'s turn"
#     # p  "#{@turn} in Check?: #{in_check?(@turn)}"
#   end
#   
#   def cursor 
#     display
#     begin
#       system("stty raw -echo")
#       input = STDIN.getc.chr
#       if input == "\e" then
#         input << STDIN.read_nonblock(3) rescue nil
#         input << STDIN.read_nonblock(2) rescue nil
#       end
#     ensure
#       system("stty -raw echo")
#     end
#     case input
#     when "\e[D"
#       @col == 1 ? @col = 8 : @col -= 1 
#     when "\e[B"
#       @row == 8 ? @row = 1 : @row += 1 
#     when "\e[C"
#       @col == 8 ? @col = 1 : @col += 1 
#     when "\e[A"
#       @row == 1 ? @row = 8 : @row -= 1 
#     when "\r"
#       if @gameboard.square(@col, @row) == []
#         puts "Sorry Empty Square, Press Enter to Continue"
#         gets    
#         play
#       elsif @gameboard.square(@col, @row).color == @turn
#         return "R" 
#         play
#       else
#         puts "Not your turn, Please press enter to continue"
#         gets
#         play
#       end
#     when "\e"
#       return "c"
#     end
#     cursor
#   end
#   
#   
#   def won?
#     # board in check
#     # no valid moves
#     false
#   end
#   
#   def move(g_board, piece, loc)
#     # !
#     # dup_piece = piece.class.new(g_board, [@col, @row], piece.color)
#     # g_board.board[loc[1]][loc[0]] = dup_piece
#     # dup_piece.pos = [loc[1],loc[0]]
#     # g_board.board[@row][@col] = []
#     # @turn == "black" ? @turn = "white" : @turn = "black"
#   end
#   
#   def play
#     until won?
#       action = cursor
#       case action
#       when "R"
#         moves_list = @gameboard.square(@col, @row).moves
#         if moves_list.empty?
#           puts "Sorry no valid moves, Press Enter to Continue"
#           gets
#           play
#         end
#           loc = [0,0]
#         until moves_list.include?([loc[0], loc[1]])
#           display
#           p "Please select your end coordinates"
#           p moves_list
#           loc = gets.chomp
#           loc = loc.split(",").map { |s| s.to_i }
#           p loc
#         end
#         move(@gameboard, @gameboard.square(@col, @row), loc.reverse)
#       when "c"
#         return         
#       end      
#     end
#   end
end