require './test/test_helper'
require './lib/board'
require './lib/ship'
require './lib/validator'
require './lib/player'

class PlayerTest < Minitest::Test
  def test_it_exists
    player = Player.new
    assert_instance_of Player, player
  end

  def test_it_has_attributes
    game = Game.new
    player = Player.new()
    assert_equal
  end

end
