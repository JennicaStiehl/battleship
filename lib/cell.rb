class Cell
  attr_reader :coordinate,
              :ship

  def initialize(coordinate)
    @coordinate = coordinate
    @ship =  nil
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
    end
    @fired_upon = true
  end

  def fired_upon?
    @fired_upon
  end

  def render(ship = false)
    if @ship != nil
      if @fired_upon == true && @ship.sunk? == true
        @render = "X"
      elsif @fired_upon == true && @ship.sunk? == false
        @render = "H"
      elsif @fired_upon == false && ship == true
        @render = "S"
      else
        @render
      end
    elsif @ship == nil
      if @fired_upon == true
        @render = "M"
      else
        @render
      end
    end
  end
end
