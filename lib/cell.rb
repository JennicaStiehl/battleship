class Cell
  attr_reader :coordinate,
              :ship,
              :render

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
        if @ship.sunk?
          @render = "X"
        else
          @render = "H"
        end
    else
      @render = "M"
    end

    @fired_upon = true
  end

  def fired_upon?
    @fired_upon
  end

  def render(ship = false)
    #binding.pry
    if ship == true
      if @ship != nil
        @render = "S"
      else
        @render
      end
    else
      @render
    end
   end
end
