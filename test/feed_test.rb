require_relative '../lib/feed'
require 'minitest/autorun'

class FeedTest < Minitest::Test
  def test_title_returns_title
    feed = Feed.new("aaa", [])
    assert feed.title == "aaa"
  end
end