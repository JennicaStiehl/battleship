require './test/test_helper'
require './lib/board'
require './lib/ship'

class BoardTest < Minitest::Test

  def test_it_exits
    board = Board.new
    assert_instance_of Board, board
  end

  def test_it_has_cells
    board = Board.new
    assert_instance_of Hash, board.cells

  end

  def test_it_can_validate_coordinate
    board = Board.new
    board.cells


    assert_equal true, board.valid_coordinate?("A1")
    assert_equal true, board.valid_coordinate?("D4")
    assert_equal false, board.valid_coordinate?("A5")
    assert_equal false, board.valid_coordinate?("E1")
    assert_equal false, board.valid_coordinate?("A22")
  end

  def test_it_can_invalidate_placement_by_length
    board = Board.new
    board.cells
    cruiser = Ship.new("curiser", 3)
    submarine = Ship.new("submarine", 2)

    assert_equal false, board.valid_placement?(cruiser, ["A1", "A2"])
    assert_equal false, board.valid_placement?(submarine, ["A1", "A2", "A3"])
  end

  def test_it_can_only_place_consecutively
    board = Board.new
    board.cells
    cruiser = Ship.new("curiser", 3)
    submarine = Ship.new("submarine", 2)

    assert_equal true, board.valid_placement?(cruiser, ["A1", "A2", "A3"])
    assert_equal false, board.valid_placement?(cruiser, ["A1", "A2", "A4"])

  end


end
