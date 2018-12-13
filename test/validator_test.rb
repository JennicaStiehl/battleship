require './test/test_helper'
require './lib/validator'
require './lib/board'
require './lib/ship'

class ValidatorTest < Minitest::Test

  def test_it_exists
    board = Board.new
    cruiser = Ship.new("curiser", 3)
    validator = Validator.new(cruiser, ["A2", "A3", "A3"], board)
    assert_instance_of Validator, validator
  end

  def test_it_has_attributes
    board = Board.new
    cruiser = Ship.new("curiser", 3)
    validator = Validator.new(cruiser, ["A2", "A3", "A3"], board)

    assert_equal cruiser, validator.ship
    assert_equal ["A2", "A3", "A3"], validator.coordinates
    assert_equal [], validator.coordinate_numbers
    assert_equal [], validator.coordinate_letters
  end

  def test_it_splits_coordinates
    board = Board.new
    cruiser = Ship.new("curiser", 3)
    validator = Validator.new(cruiser, ["A2", "A3", "A3"], board)
    assert_equal [["A", "2"], ["A", "3"], ["A", "3"]], validator.split_coordinates
  end

  def test_it_can_validate_consecutive_nums
    board = Board.new
    cruiser = Ship.new("curiser", 3)
    cruiser_1 = Ship.new("curiser", 3)
    validator = Validator.new(cruiser, ["A2", "A3", "A3"], board)
    validator_1 = Validator.new(cruiser_1, ["A1", "A2", "A3"], board)
    validator.split_coordinates
    validator_1.split_coordinates

    assert_equal false, validator.consecutive_numbers
    assert_equal true, validator_1.consecutive_numbers
  end

    def test_it_can_validate_consecutive_alphabet
      board = Board.new
      cruiser = Ship.new("curiser", 3)
      cruiser_1 = Ship.new("curiser", 3)
      validator = Validator.new(cruiser, ["A2", "A3", "A3"], board)
      validator_1 = Validator.new(cruiser_1, ["A1", "B1", "C1"], board)
      validator.split_coordinates
      validator_1.split_coordinates

      assert_equal false, validator.consecutive_alphabet
      assert_equal true, validator_1.consecutive_alphabet
    end

    def test_it_can__test_for_the_same_number
      board = Board.new
      cruiser = Ship.new("curiser", 3)
      cruiser_1 = Ship.new("curiser", 3)
      validator = Validator.new(cruiser, ["A1", "A3", "A3"], board)
      validator_1 = Validator.new(cruiser_1, ["A1", "B1", "C1"], board)
      validator.split_coordinates
      validator_1.split_coordinates

      assert_equal false, validator.same_number
      assert_equal true, validator_1.same_number
    end

  def test_it_can__test_for_the_same_letter
    board = Board.new
    cruiser = Ship.new("curiser", 3)
    cruiser_1 = Ship.new("curiser", 3)
    validator = Validator.new(cruiser, ["A1", "A3", "A3"], board)
    validator_1 = Validator.new(cruiser_1, ["A1", "B1", "C1"], board)
    validator.split_coordinates
    validator_1.split_coordinates

    assert_equal true, validator.same_alphabet
    assert_equal false, validator_1.same_alphabet
  end

  def test_it_can_validate_ship_length
    board = Board.new
    cruiser = Ship.new("curiser", 3)
    cruiser_1 = Ship.new("curiser", 3)
    validator = Validator.new(cruiser, ["A1", "A2", "A3"], board)
    validator_1 = Validator.new(cruiser_1, ["A1", "B1"], board)

    assert_equal true, validator.validation_check
    assert_equal false, validator_1.validation_check
  end

  def test_it_can_validate_consecutive_numbers_consecutive_alphabet
    board = Board.new
    cruiser = Ship.new("curiser", 3)
    cruiser_1 = Ship.new("curiser", 3)
    validator = Validator.new(cruiser, ["A1", "A2", "A3"], board)
    validator_1 = Validator.new(cruiser_1, ["A1", "B2", "C3"], board)

    assert_equal true, validator.validation_check
    assert_equal false, validator_1.validation_check
  end


  def test_it_can_validate_same_numbers_same_alphabet
    board = Board.new
    cruiser = Ship.new("curiser", 3)
    cruiser_1 = Ship.new("curiser", 3)
    validator = Validator.new(cruiser, ["A1", "A1", "A1"], board)

    assert_equal false, validator.validation_check
  end
end
