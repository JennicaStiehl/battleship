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

  def test_person_can_take_a_shot
    game = Game.new
    person = Board.new(4)
    computer = Board.new(4)
    turn_1 = Turn.new(game, person, computer)

    assert_equal true, turn_1.person_take_shot("A2")
    assert_equal false, turn_1.person_take_shot("E2")
  end

  def test_person_already_shot
    game = Game.new
    person = Board.new(4)
    computer = Board.new(4)
    turn_1 = Turn.new(game, person, computer)

    assert_equal false, turn_1.person_already_shoot?("A1")
    turn_1.fire_persons_shot("A1")
    game.player_shots << "A1"
    assert_equal true, turn_1.person_already_shoot?("A1")
  end

  def test_the_computer_can_take_a_ahot
    game = Game.new
    person = Board.new(4)
    computer = Board.new(4)
    turn_1 = Turn.new(game, person, computer)

    assert person.cells.include?(turn_1.computer_take_shot)
  end

end
