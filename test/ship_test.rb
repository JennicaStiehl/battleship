require './lib/ship'
require './test/test_helper'

class ShipTest < Minitest::Test

  def test_it_exists
    ship = Ship.new("Cruiser", 3)
    assert_instance_of Ship, ship
  end

  def test_it_has_a_name
    cruiser = Ship.new("Cruiser", 3)
    assert_equal "Cruiser", cruiser.name
  end

  def test_it_has_length
    cruiser = Ship.new("Cruiser", 3)
    assert_equal 3, cruiser.length
  end

  def test_it_has_health
    cruiser = Ship.new("Cruiser", 3)
    assert_equal 3, cruiser.health
  end

  def test_it_can_sink
    cruiser = Ship.new("Cruiser", 3)
    assert_equal false, cruiser.sunk?
  end

  
end
