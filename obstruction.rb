class Game
  attr_accessor :board, :currentPlayer

  #rn board is hardcoded to be 6x6, since I thought that the old 2d array design was causing bugs (it wasn't, it was an eronious .fill(). If I want to be able to make dynamic boards, that'll have to be for 2.0)
  def initialize
    @board = [] #makes an empry array
    6.times do #Six times, push a hash to board, with the keys representing the 'columns' in our grid
      @board.push({"0" => 0, "1" => 0, "2" => 0, "3" => 0, "4" => 0, "5" => 0 })
    end
    @currentPlayer = 1 #1 is player, 2 is AI
    @done = false #determines if the game is done or not. used in run
  end


  #Runs the game by calling turn() whenever @done is not true
  def run
    puts "Welcome to Obstruction!"
    while(!@done) do
      turn
      @done=checkDone #checks if there are still any 0s on the board
    end
    printGameBoard
    puts "Oh no! Player #{@currentPlayer} can't make any more moves!\nThanks for playing!!"

  end

  #prompts you/the Ai for a selection until it's not off the board, on top of another mark, or next to another mark
  def turn
    selectionIsGood=false
    cell = [] #the eventual coordinates of your selection
    if @currentPlayer == 1
      puts "Player #{@currentPlayer}, it's your turn!"
    else
      print "The AI is thinking"
    end
    while !selectionIsGood do
      printGameBoard if @currentPlayer==1
      puts "Please enter the coordinates of the cell you want to mark, seperated by commas." if @currentPlayer==1
      @currentPlayer==1 ? cell = gets.chomp.split(",") : cell = [rand(6), rand(6).to_s] #if currentPlayer is 1, then get the coordinates from the player, else generate them randomly
      selectionIsGood=checkCell cell #checks if those coordinates are valid
    end
    row = cell[0].to_i
    col = cell[1]
    @board[row][col]=@currentPlayer
    if @currentPlayer==2
      print "."
      sleep(0.7)
      print "."
      sleep(0.7)
      print ".\n"
      sleep(0.7)
    end
    printGameBoard
    togglePlayer #changes @currentPlayer from 1 to 2 or 2 to 1

  end

  #checks the coordinates entered, c, against the different marks on the board
  def checkCell c
    row = c[0].to_i #the number, representing the index of the board array, i.e board[1]
    col = c[1] #the string, representing the key of the hash inside each index of the board array
    if (!row.between?(0,6)||!sToI(col).between?(0,6))
      puts "Your selection is out of bounds!"
      false
    else
      #if the col+x and the row+y are between 0 - 6, then check if a player has already placed on that square
      #i.e. if col=0 and row = 1, if 0+1 and 1+0 == 1, you cannot place there
      if((row.between?(0,6)&&sToI(col, 1).between?(0,6)) && (board[row][iToS(col, 1)]==1 || board[row][iToS(col, 1)]==2))
        puts "That square is right next to another player's cell!" if @currentPlayer==1
        false
      elsif((row.between?(0,6)&&sToI(col, -1).between?(0,6)) && (board[row][iToS(col, -1)]==1 || board[row][iToS(col, -1)]==2))
          puts "That square is right next to another player's cell!" if @currentPlayer==1
        false
      elsif(((row+1).between?(0,5)&&sToI(col).between?(0,5)) && (board[row+1][iToS(col)]==1 || board[row+1][iToS(col)]==2))
          puts "That square is right next to another player's cell!" if @currentPlayer==1
        false
      elsif(((row-1).between?(0,5)&&sToI(col).between?(0,5)) && (board[row-1][iToS(col)]==1 || board[row-1][iToS(col)]==2))
          puts "That square is right next to another player's cell!" if @currentPlayer==1
        false
      elsif(((row-1).between?(0,5)&&sToI(col,-1).between?(0,5)) && (board[row-1][iToS(col,-1)]==1 || board[row-1][iToS(col,-1)]==2))
          puts "That square is right next to another player's cell!" if @currentPlayer==1
        false
      elsif(((row+1).between?(0,5)&&sToI(col,-1).between?(0,5)) && (board[row+1][iToS(col,-1)]==1 || board[row+1][iToS(col,-1)]==2))
          puts "That square is right next to another player's cell!" if @currentPlayer==1
        false
      elsif(((row+1).between?(0,5)&&sToI(col,1).between?(0,5)) && (board[row+1][iToS(col,1)]==1 || board[row+1][iToS(col,1)]==2))
          puts "That square is right next to another player's cell!" if @currentPlayer==1
        false
      elsif(((row-1).between?(0,5)&&sToI(col,1).between?(0,5)) && (board[row-1][iToS(col,1)]==1 || board[row-1][iToS(col,1)]==2))
          puts "That square is right next to another player's cell!" if @currentPlayer==1
        false
      elsif board[row][iToS(col)]==1 || board[row][iToS(col)]==2
        puts "That square is right next to another player's cell!" if @currentPlayer==1
        false
      else
        xAroundCell(row, col) #puts the Xs on the board
        true
      end
    end
  end

  #puts Xs on any tile around the current selection, visually indicating where the next player cannot place
  def xAroundCell(row, col)
    for x in -1..1
      for y in -1..1
        if (row+x).between?(0,5) && (sToI(col, y).between?(0,5))
          @board[row+x][iToS(col, y)]="X"
        end
      end

    end
  end

  #goes thru the board and checks if any value in the hashes is 0, if it is, that means there are still moves possible on the board
  def checkDone
    d = true
    @board.each do |hash|
      d=false if hash.has_value?(0)
    end
    d
  end

  #confusingly titled, iToS converts a string number (i.e. "2") to an integer, adds a number, i, to it, then returns the new integer as a string
  def iToS s, i=0
    s = s.to_i + i
    s.to_s
  end

  #same as iToS, but now converts a string number to an integer and adds a number, returning the integer
  def sToI s, i=0
    s = s.to_i + i
  end

  #prints the game board visually
  def printGameBoard
    puts "-----------------" #Helps visually indicate where the board begins and ends
    @board.each do |hash|
      hash.each do |key, value|
        print "#{value} "
      end
      puts
    end
    puts "-----------------"

  end

  #toggles @currentPlayer, if 1, change to 2; if 2, change to 1
  def togglePlayer
    @currentPlayer == 1 ? @currentPlayer = 2 : @currentPlayer = 1
  end


end
