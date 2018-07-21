class Item
  attr_reader :title, :description, :date, :link

  def self.from_raw(raw_item)
    new(
      raw_item.title,
      raw_item.description,
      raw_item.pubDdate,
      raw_item.link
    )
  end

  def initialize(title, description, date, link)
    @title, @description, @date, @link = title, description, date, link
  end
end