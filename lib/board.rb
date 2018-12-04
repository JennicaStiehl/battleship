require './lib/cell'

class Board
  attr_reader :cells

  def initialize
    @cells = {}
    @alphabet = ('A'..'D').to_a
    @num = (1..4).to_a
  end

  def cells(row = 4)
    @alphabet.each do |row|
      @num.each do |column|
        coordinate = row + column.to_s
        @cells[coordinate] = Cell.new(coordinate)
      end
    end
    @cells
  end

  def valid_coordinate?(coordinate)
    @cells.include?(coordinate)
  end

  def valid_placement?(ship, coordinates)
    if ship.length == coordinates.count
      split_coordinates = split_coordinates(coordinates)
      consecutive_numbers(ship, split_coordinates)
      consecutive_alphabet(ship, coordinates)
    else
      false
    end
  end

  def split_coordinates(coordinates)
    split_coordinates = []
    coordinates.each do |coord|
      split_coordinates << coord.chars
    end
    return split_coordinates
  end

  def consecutive_numbers(ship, split_coordinates)
    numbers = []
    split_coordinates.each do |cord|
       numbers << cord[1]
     end
     smallest = numbers.min
     largest = numbers.max
    if (smallest..largest).count == ship.length
       true
    else
       false
    end
  end

  def consecutive_alphabet(ship, split_coordinates)
    alphabet = []
    split_coordinates.each do |cord|
      alphabet << cord[0].ord
    end
    smallest = alphabet.min
    largest = alphabet.max
    if (smallest..largest).count == ship.length
      true
    else
      false
    end
  end

end
