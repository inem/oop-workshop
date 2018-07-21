class Feed
  attr_reader :title, :author, :id, :about, :link, :description

  def self.new_from_channel(channel)
    new(
      channel.title,
      channel.author,
      channel.id,
      channel.about,
      channel.link,
      channel.description
    )
  end

  def initialize(title, author, id, about, link, description)
    @title = title || "title"
    @author = author || "blank"
    @id = id
    @about = about || "about"
    @link = link
    @description = description || "desc"
  end
end