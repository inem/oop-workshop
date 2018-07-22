module FeedConverter
  module ItemsHelper
    def self.create(data)
      {
        title: data.fetch("title"),
        description: data.fetch("description"),
        date: data.fetch("pubDate"),
        link: data.fetch("link"),
        guid: data.fetch("guid"),
      }
    end

    def self.strip_out_guids(items)
      items.each{|el| el.guid = nil}
    end
  end
end