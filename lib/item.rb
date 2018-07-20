class Item
  attr_reader :title, :description, :date, :link
  def initialize(title, description, date, link)
    @title, @description, @date, @link = title, description, date, link
  end

  def <=>(a,b)
    a.date <=> b.date
  end
end