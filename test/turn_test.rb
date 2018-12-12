require './lib/ship'
require './lib/board'
require './lib/turn'
require './lib/game'
require './test/test_helper'

class TurnTest < Minitest::Test

  def test_it_exists
    game = Game.new
    player_1 = Board.new(4)
    player_2 = Board.new(4)
    turn_1 = Turn.new(game, player_1, player_2)
    assert_instance_of Turn, turn_1
  end

  def test_it_has_attributes
    game = Game.new
    person = Board.new(4)
    computer = Board.new(4)
    turn_1 = Turn.new(game, person, computer)

    assert_equal person, turn_1.person_board
    assert_equal computer, turn_1.computer_board
  end


end
