require 'rspec'
require_relative 'obstruction'

describe Game do
  it "can create a Game object" do
    expect{Game.new}.to_not raise_error
  end

  it "can create a new game board, of length 6" do
    expect(Game.new.board.length).to eq(6)
  end

  it "can convert a string to an int" do
    expect(Game.new.iToS("3", -1)).to eq(2)
  end

end

#
# describe Board do
#   it "can create a Board object" do
#     expect{Board.new}.to_not raise_error
#   end
#
#   it "can create a game board of length 6" do
#     expect(Board.new.board.length).to eq(6)
#   end
# end
