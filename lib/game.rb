require './lib/board'
require './lib/ship'

module Game
  @board


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
    self.ship_placement

  end

  def self.ship_placement
    puts "Next. Here is a list of ships to choose from."
    user_input = gets.chomp.downcase
    if user_input == "carrier"
      ship = Ship.new("Carrier", 5)
      self.ship_placement_response(ship)
    elsif user_input == "battleship"
      ship = Ship.new("Battleship", 4)
      self.ship_placement_response(ship)
    elsif user_input == "cruiser"
      ship = Ship.new("Cruiser", 3)
      self.ship_placement_response(ship)
    elsif user_input == "submarine"
      ship = Ship.new("Submarine", 3)
      self.ship_placement_response(ship)
    elsif user_input == "destroyer"
      ship = Ship.new("Destroyer", 2)
      self.ship_placement_response(ship)
    elsif user_input == "battleship"
      #ends user setup
    else
      puts "That is not a recognized ship."
      self.ship_placement(ship)
    end
  end

  def self.ship_placement_response(ship)
    puts "Where would you like to place your ship?"
    puts @board.render(true)
    user_placement = gets.chomp.split(",")
    if @board.valid_placement?(ship, user_placement) == true
        @board.place(ship, user_placement)
    elsif
      user_placement == "cancel"
    else
      puts "Sorry that is an invalid placement."
      self.ship_placement_response(ship)
    end
    self.ship_placement
  end

  def self.computer_setup(rows)
    ('A'..('A'.ord + (rows -1)).chr).rand
    (1..number).rand

  end
end
