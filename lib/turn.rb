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



  def person_take_shot(shot)
    @computer_board.valid_coordinate?(shot) == true
  end

  def person_already_shoot?(shot)
    @game.player_shots.include?(shot) == true
  end

  def fire_persons_shot(shot)
    @computer_board.fire_shot(shot)
    @player_shot = shot
  end

  def computer_take_shot
    shot = @person_board.cells.keys.shuffle[0]
    until @game.computer_shots.include?(shot) != true
      shot = @person_board.cells.keys.shuffle[0]
      end
    shot
  end

  def computer_shot(shot)
    @person_board.fire_shot(shot)
    @computer_shot = shot
  end

  #
  # def complete_turn
  #   # render_turn
  #   person_take_shot
  #   person_turn_outcome
  #   computer_take_shot
  #   comp_turn_outcome
  # end

end
