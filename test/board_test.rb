require './test/test_helper'
require './lib/board'

class BoardTest < Minitest::Test

  def test_it_exits
    board = Board.new
    assert_instance_of Board, board
  end

  def test_it_has_cells
    board = Board.new
    binding.pry
    assert_instance_of Hash, board.cells

  end
end
