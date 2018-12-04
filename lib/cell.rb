class Cell
  attr_reader :coordinate,
              :ship,
              :render

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
    if @ship != nil
      @ship.hit
      @render = "H"
    else
      @render = "M"
    end

    @fired_upon = true
  end

  def fired_upon?
    @fired_upon
  end

  def render(ship = false)
    if ship == true
      @render = "S"
    end
    @render
   end
end
