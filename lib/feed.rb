class Feed
  attr_reader :title, :items

  def initialize(title, items)
    @title = title
    @items = items
  end
end