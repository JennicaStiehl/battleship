require './lib/cell'

class Board
  attr_reader :cells

  def initialize
    @cells = {}
  end

  def cells(row = 4)
    alpha = ('A'..'D').to_a
    num = (1..row).to_a

    alpha.each do |row|
      num.each do |column|
        coordinate = row + column.to_s
        @cells[coordinate] = Cell.new(coordinate)
      end
    end

    binding.pry
  end

end
