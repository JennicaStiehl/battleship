require './lib/cell'
require './lib/validator'

class Board
  # Include Validator

  attr_reader :cells,
              :number

  def initialize(number = 4)
    @cells = {}
    @number = number.to_i
    create_board(@number)
  end

  def create_board(number)
    ('A'..('A'.ord + (number - 1)).chr).to_a.each do |row|
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
    if coordinates.class == String
      # binding.pry
      split_coordin = coordinates.split(",")
    else
      split_coordin = coordinates
    end
    placement = Validator.new(ship, split_coordin, self)
    placement.validation_check
  end

  def place(ship, coordinates)
    split_coordin = coordinates.split(",")
        split_coordin.each do |coord|
          @cells[coord].place_ship(ship)
        end

  end

  def render(ship = false)
    string = ""

    alpha = ""
    full_line = ""
     board_numbers.each do |num|
       string << " #{num}"
     end
     full_line << "#{string} \n"
    board_letters.each do |letter|
       alpha = letter
       string_1 = ""
      board_numbers.to_a.each do |num|
        key = "#{letter}#{num.to_s}"
         string_1 += "#{@cells[key].render(ship)} "
         # binding.pry
      end
      full_line << "#{alpha} #{string_1}\n"
    end
    full_line
  end

  def fire_shot(cell)
    @cells[cell].fired_upon
  end

  def board_letters
    ('A'..('A'.ord + (number - 1)).chr).to_a
  end

  def board_numbers
    (1..@number).to_a
  end

end
