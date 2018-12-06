require './test/test_helper'
require './lib/validator'
require './lib/board'
require './lib/ship'

class ValidatorTest < Minitest::Test

  def test_it_exists
    cruiser = Ship.new("curiser", 3)
    validator = Validator.new(cruiser, ["A2", "A3", "A3"])
    assert_instance_of Validator, validator
  end

  def test_it_has_attributes
    cruiser = Ship.new("curiser", 3)
    validator = Validator.new(cruiser, ["A2", "A3", "A3"])

    assert_equal cruiser, validator.ship
    assert_equal ["A2", "A3", "A3"], validator.coordinates
    assert_equal [], validator.coordinate_numbers
    assert_equal [], validator.coordinate_letters
  end

  def test_it_splits_coordinates
    cruiser = Ship.new("curiser", 3)
    validator = Validator.new(cruiser, ["A2", "A3", "A3"])
    assert_equal [["A", "2"], ["A", "3"], ["A", "3"]], validator.split_coordinates
  end

  def test_it_can_validate_consecutive_nums
    cruiser = Ship.new("curiser", 3)
    cruiser_1 = Ship.new("curiser", 3)
    validator = Validator.new(cruiser, ["A2", "A3", "A3"])
    validator_1 = Validator.new(cruiser_1, ["A1", "A2", "A3"])
    validator.split_coordinates
    validator_1.split_coordinates

    assert_equal false, validator.consecutive_numbers
    assert_equal true, validator_1.consecutive_numbers
  end

    def test_it_can_validate_consecutive_alphabet
      cruiser = Ship.new("curiser", 3)
      cruiser_1 = Ship.new("curiser", 3)
      validator = Validator.new(cruiser, ["A2", "A3", "A3"])
      validator_1 = Validator.new(cruiser_1, ["A1", "B1", "C1"])
      validator.split_coordinates
      validator_1.split_coordinates

      assert_equal false, validator.consecutive_alphabet
      assert_equal true, validator_1.consecutive_alphabet
    end

    def test_it_can__test_for_the_same_number
      cruiser = Ship.new("curiser", 3)
      cruiser_1 = Ship.new("curiser", 3)
      validator = Validator.new(cruiser, ["A1", "A3", "A3"])
      validator_1 = Validator.new(cruiser_1, ["A1", "B1", "C1"])
      validator.split_coordinates
      validator_1.split_coordinates

      assert_equal false, validator.same_number
      assert_equal true, validator_1.same_number
    end

  def test_it_can__test_for_the_same_letter
    cruiser = Ship.new("curiser", 3)
    cruiser_1 = Ship.new("curiser", 3)
    validator = Validator.new(cruiser, ["A1", "A3", "A3"])
    validator_1 = Validator.new(cruiser_1, ["A1", "B1", "C1"])
    validator.split_coordinates
    validator_1.split_coordinates

    assert_equal true, validator.same_alphabet
    assert_equal false, validator_1.same_alphabet
  end

  def test_it_can_validate_ship_length
    cruiser = Ship.new("curiser", 3)
    cruiser_1 = Ship.new("curiser", 3)
    validator = Validator.new(cruiser, ["A1", "A2", "A3"])
    validator_1 = Validator.new(cruiser_1, ["A1", "B1"])

    assert_equal true, validator.validation_check
    assert_equal false, validator_1.validation_check
  end

  def test_it_can_validate_consecutive_numbers_consecutive_alphabet
    cruiser = Ship.new("curiser", 3)
    cruiser_1 = Ship.new("curiser", 3)
    validator = Validator.new(cruiser, ["A1", "A2", "A3"])
    validator_1 = Validator.new(cruiser_1, ["A1", "B2", "C3"])

    assert_equal true, validator.validation_check
    assert_equal false, validator_1.validation_check
  end


  def test_it_can_validate_same_numbers_same_alphabet
    cruiser = Ship.new("curiser", 3)
    cruiser_1 = Ship.new("curiser", 3)
    validator = Validator.new(cruiser, ["A1", "A1", "A1"])

    assert_equal false, validator.validation_check
  end
end
