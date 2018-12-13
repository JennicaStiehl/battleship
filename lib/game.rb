require './lib/board'
require './lib/ship'
require './lib/turn'
require 'pry'

class Game

  attr_reader :player_shots,
              :computer_shots
  attr_accessor :player_health,
                :comp_health

  def initialize
    @player_shots = []
    @computer_shots = []
    @player_health = 0
    @comp_health = 0
  end


  def welcome
    puts "-" * 30
    puts "Welcome to BATTLESHIP"
    puts "-" * 30
    puts "Enter 'p' to Play! or Enter 'q' to Quit."
    print "> "
    user_input = gets.chomp
    sleep 0.5
      until user_input == "p" || user_input == "q"
        puts "That is not a valid input."
        puts "-" * 30
        sleep 1
        puts "Welcome back..."
        puts "Enter 'p' to Play! or Enter 'q' to Quit."
        print "> "
        user_input = gets.chomp.downcase
        sleep 0.5
      end
      if user_input == "p"
        puts "-" * 30
        puts "How many rows would you like your board to be?"
        print "> "
        row_size = gets.chomp.to_i
        sleep 1
        puts "How many columns would you like your board to be?"
        print "> "
        column_size = gets.chomp.to_i
        sleep 1
        until row_size < 10 && column_size < 10
          puts "-" * 30
          puts "Im sorry, the board cannot be more that 9 rows/colums."
          sleep 1
          puts "How many rows would you like your board to be?"
          print "> "
          row_size = gets.chomp.to_i
          sleep 1
          puts "How many columns would you like your board to be?"
          print "> "
          column_size = gets.chomp.to_i
          sleep 1
        end
        setup(row_size, column_size)
      else
        puts "See ya soon ;)"
        exit
      end
  end

  def setup(row_size, column_size)
    @board = Board.new(row_size, column_size)
    @comp_board = Board.new(row_size, column_size)
    puts "-" * 30
    puts "Okay great, now to choose your ships!"
    puts "Here is a list of ships for you to choose from..."
    sleep 1
    ship_list
    # until user_input == 'start'
    #   ship_creation(user_input)
    # end
    taking_turns
  end

  def ship_list
    empty_cells = []
    @comp_board.cells.values.each do |cell|
      if cell.empty? == true
        empty_cells.push(cell)
      end
    end
    empty_cells.count
    half_board = @comp_board.cells.count / 2
    if empty_cells.count < half_board
      taking_turns
    else
      puts ""
      puts "- Carrier - The mighty Aircraft Carrier. Has '5' health."
      puts "- Battleship - The all powerfull Battleship. Has '4' health."
      puts "- Cruiser - The small but strong Cruiser. Has '3' health. "
      puts "- Submarine - The unditectibale Submarine. Has '3' health."
      puts "- Destroyer - The destroyer. Quick and Powerful. Has '2' health."
      puts "- Custom - Make your own ship..."
      puts "Just type the 'name' of the ship you wish to place."
      puts ""
      puts "Or type 'start' whenever you are ready to play the game."
      print "> "
      user_input = gets.chomp.downcase
      sleep 0.5
        if user_input == "start"
          taking_turns
        else
          ship_creation(user_input)
        end
    end
  end

  def ship_length_not_too_long(ship, comp_ship)
    if ship.length <= @board.row || ship.length <= @board.column
      ship_placement_response(ship,comp_ship)
    else
      puts "That ship is too large."
      ship_list
    end
  end

  def ship_creation(user_input)
    if user_input == "carrier"
      ship = Ship.new("Carrier", 5)
      comp_ship = Ship.new("Carrier", 5)
      ship_length_not_too_long(ship,comp_ship)
    elsif user_input == "battleship"
      ship = Ship.new("Battleship", 4)
      comp_ship = Ship.new("Battleship", 4)
      ship_length_not_too_long(ship,comp_ship)
    elsif user_input == "cruiser"
      ship = Ship.new("Cruiser", 3)
      comp_ship = Ship.new("Cruiser", 3)
      ship_length_not_too_long(ship,comp_ship)
    elsif user_input == "submarine"
      ship = Ship.new("Submarine", 3)
      comp_ship = Ship.new("Submarine", 3)
      ship_length_not_too_long(ship,comp_ship)
    elsif user_input == "destroyer"
      ship = Ship.new("Destroyer", 2)
      comp_ship = Ship.new("Destroyer", 2)
      ship_length_not_too_long(ship,comp_ship)
    elsif user_input == "custom"
      puts "What will be the name of your Ship?"
      print "> "
      ship_name = gets.chomp.capitalize
      sleep 0.5
      puts "Custom ships must have more than 1 and less than 10 health."
      puts "How much health does this ship have?"
      print "> "
      ship_length = gets.chomp.to_i
      sleep 0.5
      until ship_length < 10 && ship_length > 1
        puts "Custom ships must have more than 1 and less than 10 health."
        puts "How much health does this ship have?"
        print "> "
        ship_length = gets.chomp.to_i
        sleep 0.5
      end
      ship = Ship.new(ship_name, ship_length)
      comp_ship = Ship.new(ship_name, ship_length)
      ship_length_not_too_long(ship,comp_ship)
    else
      puts "That is not a recognized ship."
      puts "Lets try that again..."
      sleep 1
      ship_list
    end
  end

  def ship_placement_response(ship, comp_ship)
    comp_cords = comp_cord_generator(comp_ship)
    puts "Where would you like to place your '#{ship.name}'?"
    puts "Select #{ship.length} coordinates..."
    puts "Or enter 'cancel' to go back to the ship selection."
    puts @board.render(true)
    user_placement = gets.chomp.upcase
    if validate_input(user_placement) == true
          if @board.valid_placement?(ship, user_placement) == true
            @board.place(ship, user_placement)
            @player_health += 1
            until @comp_board.valid_placement?(ship, comp_cords) == true
              comp_cords = comp_cord_generator(comp_ship)
            end
            @comp_board.place(comp_ship, comp_cords)
            @comp_health += 1
          else
            puts "That is an invalid placement."
          end
    elsif user_placement == "cancel"
      ship_list
    else
        puts "Sorry that is an invalid placement."
        ship_placement_response(ship, comp_ship)
    # end
    # ship_placement_response(ship, comp_ship)
    end
    ship_list
  end

  def validate_input(input)
    input_array = input.split(",")
    input_array.all? do |cord|
     @board.cells.keys.include?(cord)
    end
  end

  def comp_cord_generator(ship)
    number_of_coord = ship.length
    final_coord = ""

    empty_spaces = []
    @comp_board.cells.values.each do |value|
      if value.empty?
        empty_spaces << value.coordinate
      end
    end
    first_coord = empty_spaces.shuffle[0]
    #random = hor_or_vert = rand(0..1)
    single_digit = first_coord.split(//)
    first_coord =
    coordinates = []
    vert = []
    #if random == 1
      empty_spaces.each do |space|
        vert << space if space.include?(single_digit[1])
      end
      vert.each_cons(number_of_coord) do |group|
        coordinates << group
      end
    #else
      empty_spaces.each do |space|
        vert << space if space.include?(single_digit[0])
      end
      vert.each_cons(number_of_coord) do |group|
        coordinates << group
      end
    #end

    # empty_spaces.each_cons(number_of_coord) do |group|
    #   coordinates << group
    # end
    valid_groups = []
    coordinates.each do |coord|
      # binding.pry
      if @comp_board.valid_placement?(ship, coord) == true
        valid_groups << coord
      end
    end
    valid_groups.shuffle!
    coords = valid_groups[0]
    coords.each do |coord|
    final_coord << coord + ','
    end
    final_coord
  end

  def take_turn
     turn = Turn.new(self, @board, @comp_board)
     puts "Please enter a coordinate."
     shot = gets.chomp.upcase
     until turn.person_take_shot(shot) == true
       puts "Sorry that is an invalid coordinates"
       shot = gets.chomp.upcase
     end
     until turn.person_already_shoot?(shot) != true
       puts "You have already fired at that location!"
       shot = gets.chomp.upcase
     end
     turn.fire_persons_shot(shot)
     @player_shots << shot
     comp_shot = turn.computer_take_shot
     turn.computer_shot(comp_shot)
     @computer_shots << comp_shot
     person_turn_outcome(shot)
     comp_turn_outcome(comp_shot)
   end

  def taking_turns
    until @player_health < 1 || @comp_health < 1
      render_boards
      take_turn
    end
  end_game
  end

  def render_boards
    puts "=" * 15 + " Computer Board " + "=" * 15
    puts @comp_board.render(false)
    puts "=" * 15 + " Player Board " + "=" * 16
    puts @board.render(true)
  end

  def person_turn_outcome(shot)
    cell = @comp_board.cells[shot]
    if  cell.empty? == true
        puts "You missed!"
    elsif  cell.ship.sunk? == true
      puts "You sunk my #{cell.ship.name}!"
      self.comp_health -= 1
    else
      puts "Stahp. You hit my ship!"
    end
  end

  def comp_turn_outcome(shot)
    cell = @board.cells[shot]
    if cell.empty? == true
      puts "i missed my shot!"
    elsif cell.ship.sunk?
      "It loks like i sunk your #{cell.ship.name}!"
      self.player_health -= 1
    else
      puts "I hit one of your ships!"
    end
  end

  def end_game
    if @player_health < 1
      puts "I Win!"
    elsif @comp_health < 1
      puts "You got lucky!"
    end
  puts "Would you like to play another game?!"
  puts "Enter 'y' to play again... or enter 'n' to exit."
  user_input = gets.chomp.downcase
  sleep 1
  until user_input == "y" || user_input == "n"
    user_input = gets.chomp.downcase
  end
    if user_input == "y"
      welcome
    elsif user_input == "n"
      puts "Goodbye!"
        exit
    end
  end

end
