require './lib/board'
require './lib/ship'
require 'pry'

module Game
  @board
  @comp_board


  def self.welcome
    puts "Welcome to BATTLESHIP"
    puts "Enter 'p' to Play! or Enter 'q' to Quit."
    user_input = gets.chomp
      if user_input == "p"
        puts "How rows would you like your board?"
        board_size = gets.chomp
        self.setup(board_size)
      elsif user_input == "q"

      else
        puts "That is not a valid input."
        puts "-" * 30
        sleep 1
        self.welcome
      end
  end

  def self.setup(rows)
    @board = Board.new(rows)
    @comp_board = Board.new(rows)
    self.ship_placement

  end

  def self.ship_placement
    puts "Next. Here is a list of ships to choose from."
    user_input = gets.chomp.downcase
    if user_input == "carrier"
      ship = Ship.new("Carrier", 5)
      comp_ship = Ship.new("Carrier", 5)
      self.ship_placement_response(ship, comp_ship)
    elsif user_input == "battleship"
      ship = Ship.new("Battleship", 4)
      comp_ship = Ship.new("Battleship", 4)
      self.ship_placement_response(ship, comp_ship)
    elsif user_input == "cruiser"
      ship = Ship.new("Cruiser", 3)
      comp_ship = Ship.new("Cruiser", 3)
      self.ship_placement_response(ship, comp_ship)
    elsif user_input == "submarine"
      ship = Ship.new("Submarine", 3)
      comp_ship = Ship.new("Submarine", 3)
      self.ship_placement_response(ship, comp_ship)
    elsif user_input == "destroyer"
      ship = Ship.new("Destroyer", 2)
      comp_ship = Ship.new("Destroyer", 2)
      self.ship_placement_response(ship, comp_ship)
    elsif user_input == "battleship"
      #ends user setup
    else
      puts "That is not a recognized ship."
      self.ship_placement
    end
  end

  def self.ship_placement_response(ship, comp_ship)
    comp_cords = self.comp_cord_generator(comp_ship)
    puts "Where would you like to place your ship?"
    puts @board.render(true)
    user_placement = gets.chomp
    if self.validate_input(user_placement) == true
          if user_placement == "cancel"
            self.ship_placement
          elsif @board.valid_placement?(ship, user_placement) == true
            @board.place(ship, user_placement)
            until @comp_board.valid_placement?(ship, comp_cords) == true
              comp_cords = self.comp_cord_generator(comp_ship)
            end
            @comp_board.place(comp_ship, comp_cords)
          else
            puts "Sorry that is an invalid placement."
            self.ship_placement_response(ship, comp_ship)
          end
    end
    self.ship_placement
  end

  def self.validate_input(input)
    input_array = input.split(",")
    input_array.all? do |cord|
     @board.cells.keys.include?(cord)
    end
  end

  def self.comp_cord_generator(ship)
    number_of_coord = ship.length
    rows = @comp_board.number
    final_coord = ""

    number_of_coord.times do
    alpha_var = rand('A'.ord..('A'.ord + (rows - 1))).chr
    num_var = rand(1..rows).to_s
    final_coord << alpha_var + num_var + ","
    end
    final_coord
  end






  def self.computer_setup(rows)
    ('A'..('A'.ord + (rows -1)).chr).rand
    (1..number).rand

  end
end
