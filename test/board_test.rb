require './test/test_helper'
require './lib/board'
require './lib/ship'
require './lib/validator'

class BoardTest < Minitest::Test

  def test_it_exits
    # skip
    board = Board.new(4)
    assert_instance_of Board, board
  end

  def test_it_has_cells
    # skip
    board = Board.new
    assert_instance_of Hash, board.cells

  end

  def test_it_can_validate_coordinate
    # skip
    board = Board.new



    assert_equal true, board.valid_coordinate?("A1")
    assert_equal true, board.valid_coordinate?("D4")
    assert_equal false, board.valid_coordinate?("A5")
    assert_equal false, board.valid_coordinate?("E1")
    assert_equal false, board.valid_coordinate?("A22")
  end

  def test_it_can_invalidate_placement_by_length
    # skip
    board = Board.new

    cruiser = Ship.new("curiser", 3)
    submarine = Ship.new("submarine", 2)

    assert_equal false, board.valid_placement?(cruiser, ["A1", "A2"])
    assert_equal false, board.valid_placement?(submarine, ["A1", "A2", "A3"])
  end

  def test_it_can_only_place_consecutively
    # skip
    board = Board.new

    cruiser = Ship.new("curiser", 3)
    submarine = Ship.new("submarine", 2)

    assert_equal true, board.valid_placement?(cruiser, ["A1", "A2", "A3"])
    assert_equal false, board.valid_placement?(cruiser, ["A1", "A2", "A4"])
    assert_equal false, board.valid_placement?(submarine, ["A1", "C1"])
  end

  def test_it_cant_place_diagonal
    # skip
    board = Board.new

    cruiser = Ship.new("curiser", 3)
    submarine = Ship.new("submarine", 2)

    assert_equal false, board.valid_placement?(cruiser, ["A1", "B2", "C3"])
    assert_equal false, board.valid_placement?(cruiser, ["C2", "D3"])
  end

  def test_it_can_place_ships
    # skip
    board = Board.new
    cruiser = Ship.new("curiser", 3)

    # binding.pry
    board.place(cruiser, ["A1","A2","A3"] )
    cell_1 = board.cells["A1"]
    cell_2 = board.cells["A2"]
    cell_3 = board.cells["A3"]
    assert_equal cruiser, cell_1.ship
    assert_equal cruiser, cell_2.ship
    assert_equal cruiser, cell_3.ship
  end

  def test_ships_cannot_over_lap
    # skip
    board = Board.new

    cruiser = Ship.new("curiser", 3)
    submarine = Ship.new("submarine", 2)
    board.place(cruiser, ["A1","A2","A3"])


    assert_equal false, board.valid_placement?(submarine, ["A2","B2"])
  end

  def test_board_can_render_user_and_comp_boards
    board = Board.new
    cruiser = Ship.new("curiser", 3)
    board.place(cruiser, ["A1","A2","A3"])

    exact = " 1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n"
    exact_1 = " 1 2 3 4 \nA S S S . \nB . . . . \nC . . . . \nD . . . . \n"

    assert_equal exact, board.render
    assert_equal exact_1, board.render(true)
  end

  def test_board_can_render_hits_and_misses_for_user_and_comp
    board = Board.new
    cruiser = Ship.new("curiser", 3)
    submarine = Ship.new("submarine", 2)
    board.place(cruiser, ["A1","A2","A3"])
    board.place(submarine, ["C1", "D1"])
    board.fire_shot("A1")
    board.fire_shot("B4")
    board.fire_shot("C1")
    board.fire_shot("D1")

    assert_equal " 1 2 3 4 \nA H . . . \nB . . . M \nC X . . . \nD X . . . \n", board.render
  end



end
