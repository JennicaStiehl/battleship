module Validator

  def split_coordinates(coordinates)
    split_coordinates = []
    coordinates.each do |coord|
      split_coordinates << coord.chars
    end
    split_coordinates
  end

  def coordinate_numbers(split_coordinates)
    coordinate_numbers = []
    split_coordinates.each do |number|
      coordinate_numbers << number[1]
    end
    coordinate_numbers
  end

  def coordinate_letters(split_coordinates)
    coordinate_letters = []
    split_coordinates.each do |letter|
      coordinate_letters << letter[0].ord
    end
    coordinate_letters
  end

  def consecutive_numbers(coordinates, ship)
    smallest = coordinates.min#@coordinate_numbers.min
    largest = coordinates.max#@coordinate_numbers.max
    (smallest..largest).count == ship.length
  end

  def consecutive_alphabet(coordinates, ship)
    smallest = coordinates.min#@coordinate_numbers.min
    largest = coordinates.max#@coordinate_numbers.max
    (smallest..largest).count == ship.length
  end

  def same_number(coordinates)
    coordinates.uniq == [coordinates[0]]
  end

  def same_alphabet(coordinates)
    coordinates.uniq == [coordinates[0]]
  end

  def overlapping_ships(coordinates, board)
    coordinates.each do |coord|
      if board.cells[coord].empty? == true #@board
        return true
      else
        return false
      end
    end
  end

  def validation_check(ship, coordinates, board)
    if overlapping_ships(coordinates, board)
      split_coordinates = split_coordinates(coordinates)
      coordinate_numbers = coordinate_numbers(split_coordinates)
      coordinates_letters = coordinate_letters(split_coordinates)
      if coordinates.uniq.count != ship.length #@ship
        return false
      elsif consecutive_numbers(coordinate_numbers,ship) && consecutive_alphabet(coordinates_letters,ship)
        return false
      elsif consecutive_numbers(coordinate_numbers,ship) && same_alphabet(coordinates_letters)
        return true
      elsif same_number(coordinate_numbers) && consecutive_alphabet(coordinates_letters,ship)
        return true
      else
        return false
      end
    else
      return false
    end
  end

end
