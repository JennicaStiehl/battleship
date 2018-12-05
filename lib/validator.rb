require 'pry'
class Validator

  def initialize(ship, coordinates)
    @ship = ship
    @coordinates = coordinates
    @split_coordinates = []
    @coordinate_numbers = []
    @coordinate_letters = []
    @valid_placement = false
  end

  def split_coordinates
    @coordinates.each do |coord|
      @split_coordinates << coord.chars
    end
    @split_coordinates.each do |number|
      @coordinate_numbers << number[1]
    end
    @split_coordinates.each do |letter|
      @coordinate_letters << letter[0].ord
    end
  end

  def consecutive_numbers
    smallest = @coordinate_numbers.min
    largest = @coordinate_numbers.max
    (smallest..largest).count == @ship.length
  end

  def consecutive_alphabet
    smallest = @coordinate_letters.min
    largest = @coordinate_letters.max
    (smallest..largest).count == @ship.length
  end

  def same_number
    @coordinate_numbers.uniq == [@coordinate_numbers[0]]
  end

  def same_alphabet
    @coordinate_letters.uniq == [@coordinate_letters[0]]
  end

  def validation_check
    split_coordinates
    if @coordinates.count != @ship.length
      @valid_placement = false
    elsif consecutive_numbers && consecutive_alphabet
      @valid_placement = false
    elsif consecutive_numbers && same_alphabet
      @valid_placement = true
    elsif same_number && same_alphabet
      @valid_placement = false
    elsif same_number && consecutive_alphabet
      @valid_placement = true
    end
    @valid_placement
  end

end
