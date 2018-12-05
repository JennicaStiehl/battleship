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
    placement = Validator.new(ship, coordinates)
    placement.validation_check
  end

end
