require './lib/board'

class Turn
  attr_reader :person,
              :computer,
              :player_shot

  def initialize(person, computer)
    @person = person
    @computer = computer
  end

  def render_turn
    puts "=" * 15 + " Computer Board " + "=" * 15
    puts @computer.render(false)
    puts "=" * 15 + " Player Board " + "=" * 16
    puts @person.render(true)
  end

  def person_take_shot
    puts "Please enter a coordinate."
    shot = gets.chomp
    until @person.valid_coordinate?(shot) == true
      @person.fire_shot(shot)
      @player_shot = shot
    puts "Please try again."
    end
  end

  def computer_take_shot

  if @computer.valid_coordinate?(coordinate) == true
    @computer.fire_shot(coordinate)
  end

end
