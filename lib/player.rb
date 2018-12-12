class Player
  attr_accessor :board

  def initialize
    @shots = []
    @health = 0
    @board = nil
  end

  def take_turn
    Turn.new
  end

end
