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

  def test_was_it_fired_at
    cell = Cell.new("B4")
    cruiser = Ship.new("cruiser", 3)
    cell.place_ship(cruiser)

    assert_equal false, cell.fired_upon?
  end

  def test_it_can_fire_at_ship
    cell = Cell.new("B4")
    cruiser = Ship.new("cruiser", 3)
    cell.place_ship(cruiser)
    cell.fired_upon

    assert_equal 2, cell.ship.health
  end

  def test_cell_renders
    cell = Cell.new("B4")
    assert_equal ".", cell.render
  end

  def test_it_can_be_fired_upon_with_no_ship
    cell = Cell.new("B4")
    cell.fired_upon
    assert_equal "M", cell.render
  end

  def test_it_can_render_a_ship
    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser",3)
    cell.place_ship(cruiser)

    assert_equal "S", cell.render(true)
  end

  def test_it_can_render_a_hit
    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser",3)
    cell.place_ship(cruiser)
    cell.render(true)
    cell.fired_upon

    assert_equal "H", cell.render
  end


end
