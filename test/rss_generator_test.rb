require_relative '../lib/operations'
require 'minitest/autorun'

class RssGeneratorTest < Minitest::Test
  def test_sort_sorts
    RssGenerator.sort([])
    assert feed.title == "aaa"
  end
end