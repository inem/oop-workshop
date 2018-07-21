class RssGenerator
  def initialize(feed)
    @feed = feed
  end

  def generate
    rss = RSS::Maker.make("1.0") do |maker|
      maker.channel.author = feed.author
      maker.channel.title = feed.title
      maker.channel.id = feed.id
      maker.channel.about = feed.about
      maker.channel.link = feed.link
      maker.channel.description = feed.description
      maker.channel.updated = Time.now.to_s

      items.each do |item|
        maker.items.new_item do |new_item|
          new_item.title = item.title
          # new_item.guid = item.guid
          new_item.description = item.description
          new_item.pubDate = item.pubDate
          new_item.link = item.link
        end
      end
    end
  end
end