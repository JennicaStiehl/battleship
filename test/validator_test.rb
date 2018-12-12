require './test/test_helper'
require './lib/validator'
require './lib/board'
require './lib/ship'

class ValidatorTest < Minitest::Test
  include Validator

  def test_it_splits_coordinates
    assert_equal [["A", "1"], ["A", "2"], ["A", "3"]], split_coordinates(["A1","A2","A3"])
  end

  def test_it_can_get_coordinate_numbers
    split_coordinates = split_coordinates(["A1","A2","A3"])
    assert_equal ["1", "2", "3"], coordinate_numbers(split_coordinates)
  end

  def test_it_can_get_coordinate_letters
    split_coordinates = split_coordinates(["A1","A2","A3"])
    assert_equal [65, 65, 65], coordinate_letters(split_coordinates)
  end

  def test_it_get_consecutive_numbers
    ship = Ship.new("Cruiser", 2)
    split_coordinates = split_coordinates(["A1","A2"])
    coordinates = coordinate_numbers(split_coordinates)
    cons = consecutive_numbers(coordinates, ship)

    assert_equal true, cons
  end

    def test_it_get_consecutive_letters
      ship = Ship.new("Cruiser", 2)
      split_coordinates = split_coordinates(["A1","B1"])
      coordinates = coordinate_letters(split_coordinates)
      cons = consecutive_alphabet(coordinates, ship)

      assert_equal true, cons
    end

    def test_it_validate_same_number
      split_coordinates = split_coordinates(["A1","B1"])
      coordinates = coordinate_numbers(split_coordinates)
      cons = same_number(coordinates)

      assert_equal true, cons
    end

    def test_it_validate_same_alphabet
      split_coordinates = split_coordinates(["A1","A2"])
      coordinates = coordinate_letters(split_coordinates)
      cons = same_alphabet(coordinates)

      assert_equal true, cons
    end

    def test_it_can_validate_overlaps
      board = Board.new
      cruiser = Ship.new("curiser", 3)
      submarine = Ship.new("submarine", 2)
      actual = overlapping_ships(["A1","A2","A3"] , board)

      assert_equal true, actual
    end
end
