require "bundler/setup"
require 'oga'
require 'open-uri'
require 'rss'

module ReaderChooser
  def self.choose(source)
    source =~ /^http/ ? HttpReader : FileReader
  end
end

module FileReader
  def self.read(source)
    File.read(sourse)
  end
end

module HttpReader
  def self.read(source)
    open(source).read
  end
end

module ParserChooser
  def self.choose(format)
    format == "rss" ? RssParser : AtomParser
  end
end

module RssParser
  def self.read(feed_content)
    raw_feed = RSS::Parser.parse(feed_content)
    Oga.parse_xml(raw_feed)
  end
end

module AtomParser
  def self.read(feed_content)
    raw_feed = RSS::Parser.parse(feed_content)
    Oga.parse_xml(raw_feed)
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
    raw_feed = ParserChooser.choose(options[:format]).read(feed_content)
  end
end