class RssGenerator
  def initialize(builder = Builder::XmlMarkup)
    @builder = builder.new(indent: 4)
  end

  def generate(feed)
    @builder.instruct!
    @builder.rss(version: "2.0") do |b|
      b.channel do |bb|
        b.title          feed.info.title
        b.description    feed.info.description
        b.link           feed.info.link
        b.managingEditor feed.info.author
        #b.lastBuildDate  Time.now

        feed.items.map{|item| generate_item(item, b) }
      end
    end
  end

  def generate_item(item, builder)
    builder.item do |b|
      b.title       item.title
      b.description item.description
      b.link        item.link
      b.pubDate     item.date
      b.guid(item.guid) if item.guid
    end
  end
end
