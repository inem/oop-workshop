class Feed
  attr_reader :title, :items

  def initialize(title, items)
    @title = title
    @items = items.each{|i| Item.new(i.title, i.description, i.pubDate, i.link) }
  end

  def sort
    Feed.new title, items.sort{|item| item.pubDate }
  end

  def reverse
    Feed.new title, items.reverse
  end

  def limit(number)
    Feed.new title, items[0...number]
  end
end