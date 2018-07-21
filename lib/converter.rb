require 'crack'
require 'crack/xml'
require 'open-uri'

module ReaderChooser
  def self.choose(source)
    source =~ /^https?\:\// ? HttpReader : FileReader
  end
end

module FileReader
  def self.read(source)
    File.read(source)
  end
end

module HttpReader
  def self.read(source)
    open(source).read
  end
end

module ParserChooser
  def self.choose(format)
    variants = {
      "rss" => RssParser,
      "atom" => AtomParser
    }
    variants.fetch(format)
  end
end

class RssParser
  def initialize(engine = Crack::XML)
    @engine = engine
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
    items = items_data.each do |item_data|
      Item.new(
        item_data.fetch("title"),
        item_data.fetch("description"),
        item_data.fetch("pubDate"),
        item_data.fetch("link"),
        item_data.fetch("guid"),
      )
    end

    Feed.new(info, items)
  end
end

class AtomParser
  def initialize(engine = Crack::XML)
    @engine = engine
  end

  def parse(feed_content)
    hash = @engine.parse(feed_content)

    data = hash.fetch("rss").fetch("channel")
    items_data = data.delete("item")

    info = Info.new(
      data.fetch("title"),
      data.fetch("webMaster"),
      data.fetch("link"),
      data.fetch("description"),
    )
    items = items_data.each do |item_data|
      Item.new(
        item_data.fetch("title"),
        item_data.fetch("description"),
        item_data.fetch("pubDate"),
        item_data.fetch("link"),
        item_data.fetch("guid"),
      )
    end

    Feed.new(info, items)
  end
end

class Converter
  DEFAULTS = {
    reverse: false,
    sort: false,
    format: "rss",
    limit: false
  }

  attr_reader :options
  def initialize(options = {})
    @options = DEFAULTS.merge(options)
  end

  def convert(source)
    feed_content = ReaderChooser.choose(source).read(source)
    parser = ParserChooser.choose(options[:format]).new

    raw_feed = parser.parse(feed_content)
  end
end