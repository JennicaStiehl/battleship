require './lib/board'

class Turn
  attr_reader :person_board,
              :computer_board,
              :player_shot,
              :computer_shot

  def initialize(game, person, computer)
    @person_board = person
    @computer_board = computer
    @game = game
  end

  def render_turn
    puts "=" * 15 + " Computer Board " + "=" * 15
    puts @computer_board.render(false)
    puts "=" * 15 + " Player Board " + "=" * 16
    puts @person_board.render(true)
  end

  def person_take_shot
    puts "Please enter a coordinate."
    shot = gets.chomp.upcase
    if @computer_board.valid_coordinate?(shot) == true
      if @game.player_shots.include?(shot) == true
        puts "You have already fired at that location!"
        person_take_shot
      else
        @computer_board.fire_shot(shot)
        @player_shot = shot
      end
    else
      puts "Please try again."
      person_take_shot
    end
  end

  def computer_take_shot
    shot = @person_board.cells.keys.shuffle[0]
    until @game.computer_shots.include?(shot) != true
      shot = @person_board.cells.keys.shuffle[0]
    end
    @person_board.fire_shot(shot)
    @computer_shot = shot
  end

  def person_turn_outcome
    cell = @computer_board.cells[@player_shot]
    if  cell.empty? == true
        puts "You missed!"
    elsif  cell.ship.sunk? == true
      puts "You sunk my #{cell.ship.name}!"
      @game.comp_health -= 1
    else
      puts "Stahp. You hit my ship!"
    end
  end

  def comp_turn_outcome
    cell = @person_board.cells[@computer_shot]
    if cell.empty? == true
      puts "i missed my shot!"
    elsif cell.ship.sunk?
      "It loks like i sunk your #{cell.ship.name}!"
      @game.player_health -= 1
    else
      puts "I hit one of your ships!"
    end
  end

  def complete_turn
    render_turn
    person_take_shot
    person_turn_outcome
    computer_take_shot
    comp_turn_outcome
  end

end
