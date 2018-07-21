class Info
  attr_reader :title, :author, :link, :description

  def initialize(title, author, link, description)
    @title = title || "title"
    @author = author || "blank"
    @link = link
    @description = description || "desc"
  end
end

class Item
  attr_reader :title, :description, :date, :link, :guid

  def initialize(title, description, date, link, guid)
    @title, @description, @date, @link, @guid = title, description, date, link, guid
  end
end

class Feed
  def initialize(info, items)
    @info = info
    @items = items
  end
end