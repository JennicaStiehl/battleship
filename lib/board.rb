require './lib/cell'
require './lib/validator'

class Board
  attr_reader :cells

  def initialize(number = 4)
    @cells = {}
    create_board(number)
  end

  def create_board(number)
    ('A'..('A'.ord + (number -1)).chr).to_a.each do |row|
      (1..number).to_a.each do |column|
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
    placement = Validator.new(ship, coordinates)
    placement.validation_check
  end

  def place(ship, coordinates)
      coordinates.each do |coord|
        @cells[coord].place_ship(ship)
      end
  end
end
