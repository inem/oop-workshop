require 'crack'
require 'crack/xml'
require 'open-uri'

require_relative 'feed_converter/generator'
require_relative 'feed_converter/parser'
require_relative 'feed_converter/reader'

module FeedConverter
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
      feed_content = Reader.choose(source).read(source)
      parser = Parser.choose(feed_content).new

      feed = parser.parse(feed_content)
      generator = Generator.choose(options[:format]).new
      generator.generate(feed)
    end
  end
end