require './lib/ship'
require './lib/board'
require './lib/turn'
require './test/test_helper'

class TurnTest < Minitest::Test

  def test_it_exists
    player_1 = Board.new(4)
    player_2 = Board.new(4)
    turn_1 = Turn.new(player_1, player_2)
    assert_instance_of Turn, turn_1
  end

  def test_it_has_attributes
    person = Board.new(4)
    computer = Board.new(4)
    turn_1 = Turn.new(person, computer)

    assert_equal person, turn_1.person
  end

  def test_it_can_fire_shots
    person = Board.new(4)
    computer = Board.new(4)
    turn_1 = Turn.new(person, computer)
    turn_1.take_shot  

  end

end
