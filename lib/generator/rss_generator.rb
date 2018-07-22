class RssGenerator
  def initialize(builder = Builder::XmlMarkup)
    @builder = builder.new(indent: 4)
  end

  def generate(feed)
    info = feed.fetch :info
    items = feed.fetch :items

    @builder.instruct!
    @builder.rss(version: "2.0") do |b|
      b.channel do |bb|
        b.title          info.fetch(:title)
        b.description    info.fetch(:description)
        b.link           info.fetch(:link)
        b.managingEditor info.fetch(:author)
        #b.lastBuildDate  Time.now

        items.map{|item| generate_item(item, b) }
      end
    end
  end

  def generate_item(item, builder)
    builder.item do |b|
      b.title       item.fetch(:title)
      b.description item.fetch(:description)
      b.link        item.fetch(:link)
      b.pubDate     item.fetch(:date)
      b.guid(item[:guid]) if item[:guid]
    end
  end
end
