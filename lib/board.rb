require './lib/cell'

class Board
  attr_reader :cells

  def initialize
    @cells = {}
  end

  def cells(row = 4)
    alpha = ('A'..'Z').to_a
    num = (1..row).to_a
    @cells = {}
    alpha.each do |letter|
      row.times do |blk|
        @cells[letter + num.to_s] = Cell.new(letter + num.to_s)
      end
    end
    binding.pry
  end

end
