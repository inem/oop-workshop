class AtomGenerator
  def initialize(builder = Builder::XmlMarkup)
    @builder = builder.new
  end

  def generate(feed)
    @builder.instruct!
    @builder.rss("version" => "2.0", "xmlns:atom" => "http://www.w3.org/2005/Atom") do |b|
      b.channel do |bb|
        b.title          feed.info.title
        b.description    feed.info.description
        b.link           feed.info.link
        b.webMaster      feed.info.author

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
