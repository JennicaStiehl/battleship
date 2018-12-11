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
        puts "How many rows/columns would you like your board to be?"
        print "> "
        board_size = gets.chomp.to_i
        sleep 0.5
        until board_size < 9
          puts "-" * 30
          puts "Im sorry, the board cannot be more that 9 rows/colums."
          sleep 1
          puts "How many rows/columns would you like your board to be?"
          print "> "
          board_size = gets.chomp.to_i
          sleep 1
        end
        setup(board_size)
      else
        puts "See ya soon ;)"
      end
  end

  def setup(rows)
    @board = Board.new(rows)
    @comp_board = Board.new(rows)
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

  def ship_creation(user_input)
    if user_input == "carrier"
      ship = Ship.new("Carrier", 5)
      comp_ship = Ship.new("Carrier", 5)
      ship_placement_response(ship, comp_ship)
    elsif user_input == "battleship"
      ship = Ship.new("Battleship", 4)
      comp_ship = Ship.new("Battleship", 4)
      ship_placement_response(ship, comp_ship)
    elsif user_input == "cruiser"
      ship = Ship.new("Cruiser", 3)
      comp_ship = Ship.new("Cruiser", 3)
      ship_placement_response(ship, comp_ship)
    elsif user_input == "submarine"
      ship = Ship.new("Submarine", 3)
      comp_ship = Ship.new("Submarine", 3)
      ship_placement_response(ship, comp_ship)
    elsif user_input == "destroyer"
      ship = Ship.new("Destroyer", 2)
      comp_ship = Ship.new("Destroyer", 2)
      ship_placement_response(ship, comp_ship)
    elsif user_input == "custom"
      puts "What will be the name of your Ship?"
      print "> "
      ship_name = gets.chomp.capitalize
      sleep 0.5
      puts "How much health(up to 9) does this ship have?"
      print "> "
      ship_length = gets.chomp.to_i
      sleep 0.5
      ship = Ship.new(ship_name, ship_length)
      comp_ship = Ship.new(ship_name, ship_length)
      ship_placement_response(ship, comp_ship)
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
    puts "Go ahead and place as many ships as you would like..."
    puts "Keep in mind.. I get them too!"
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
    rows = @comp_board.number
    final_coord = ""

    empty_spaces = []
    @comp_board.cells.values.each do |value|
      if value.empty?
        empty_spaces << value.coordinate
      end
    end
    first_coord = empty_spaces.shuffle[0]
    random = hor_or_vert = rand(0..1)
    single_digit = first_coord.split(//)
    first_coord =
    coordinates = []
    vert = []
    if random == 1
      empty_spaces.each do |space|
        vert << space if space.include?(single_digit[1])
      end
      vert.each_cons(number_of_coord) do |group|
        coordinates << group
      end
    else
      empty_spaces.each do |space|
        vert << space if space.include?(single_digit[0])
      end
      vert.each_cons(number_of_coord) do |group|
        coordinates << group
      end
    end

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
    turn.complete_turn
    player_shots << turn.player_shot
    computer_shots << turn.computer_shot
        #render both boards
    #report results
  end

  def taking_turns
    until @player_health < 1 || @comp_health < 1
      take_turn
      break
    end
  end_game
  end

  def end_game
    if @player_health < 1
      puts "I Win!"
    elsif @comp_health < 1
      puts "You got lucky!"
    end
  puts "Would you like to play another game?! (y/n)"
  user_input = gets.chomp.downcase
  sleep 1
    until user_input == "y" || user_input == "n"
      if user_input == "y"
      welcome
      elsif user_input == "n"
        # if comp_health < 1
          puts "I'll get you next time!"

        # elsif player_health < 1
          puts "Better luck next time!"
          puts "Goodbye!"
          break
      end
    end
  end

end
