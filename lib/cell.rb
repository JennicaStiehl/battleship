class Cell
  attr_reader :coordinate,
              :ship

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @empty = true
    @fired_upon = false
    @render = "."
  end

  def empty?
    @empty
  end

  def place_ship(ship)
    @empty = false
    @ship = ship
  end

  def fired_upon
    @fired_upon = true
    if @ship != nil
      @ship.hit
    end
  end

  def fired_upon?
    @fired_upon
  end

  def render(ship = false)
    if ship == true
      if fired_upon? == false
        "S"
      elsif fired_upon? == true
         "H"
       end
    elsif fired_upon?
      "M"
    else "."
    end
  end

end
