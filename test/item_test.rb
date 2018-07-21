require 'ostruct'
require_relative '../lib/item'
require 'minitest/autorun'

class ItemTest < Minitest::Test
  def test_title_returns_title
    raw_item = OpenStruct.new(
      pubDate: "24.04.2008",
      title: "AAA",
      description: "BBB",
      link: "https://railshurts.com"
    )

    item = Item.from_raw(raw_item)

    assert { item.title == "AAA" }
    assert { item.date == "24.04.2008" }
    assert { item.description == "BBB" }
    assert { item.link == "https://railshurts.com" }
  end
end