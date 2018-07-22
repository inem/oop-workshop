class RssParser
  def initialize(engine = Crack::XML, options = {})
    @engine = engine
    @options = {strip_ids: false}.merge options
  end

  def parse(feed_content)
    hash = @engine.parse(feed_content)

    data = hash.fetch("rss").fetch("channel")
    items_data = data.delete("item")

    info = Info.new(
      data.fetch("title"),
      data.fetch("managingEditor"),
      data.fetch("link"),
      data.fetch("description"),
    )
    items = items_data.map{|el| ItemsHelper.create el }
    items = ItemsHelper.strip_out_guids!(items) if @options[:strip_ids]

    Feed.new(info, items)
  end

  private

  def strip_ids!(items)
    items.each{|el| el.guid = nil}
  end
end