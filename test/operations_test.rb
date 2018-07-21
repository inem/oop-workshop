require_relative 'test_helper'
require_relative '../lib/operations'


class OperationsTest < Minitest::Test
  def test_sort_sorts
    sorting_method = -> (a, b) { a <=> b }
    result = Operations.sort([3,1,2], sorting_method)
    assert result == [1,2,3]
  end

  def test_limit_limiits
    items = [3,1,2]
    result = Operations.limit(items, 2)
    assert result == [3,1]

    result = Operations.limit(items, 1)
    assert result == [3]
  end

  def test_reverse
    items = [3,1,2]

    result = Operations.reverse(items)
    assert result == [2,1,3]
  end
end