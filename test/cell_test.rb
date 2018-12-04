require './test/test_helper'
require './lib/cell'
require './lib/ship'

class CellTest < Minitest::Test

  def test_it_exists
    cell = Cell.new("B4")
    assert_instance_of Cell, cell
  end

  def test_it_has_a_coordinate
    cell = Cell.new("B4")
    assert_equal "B4", cell.coordinate
  end

  def test_it_has_a_ship
    cell = Cell.new("B4")

    assert_nil cell.ship
  end

  def test_it_starts_empty
    cell = Cell.new("B4")

    assert_equal true, cell.empty?
  end

  def test_it_can_place_ship
    cell = Cell.new("B4")
    cruiser = Ship.new("cruiser", 3)
    cell.place_ship(cruiser)

    assert_equal cruiser, cell.ship
  end

  def test_that_it_is_not_empty
    cell = Cell.new("B4")
    cruiser = Ship.new("cruiser", 3)
    cell.place_ship(cruiser)

    assert_equal false, cell.empty?
  end
end
