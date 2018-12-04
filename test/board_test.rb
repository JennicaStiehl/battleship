require './test/test_helper'
require './lib/board'

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

end
