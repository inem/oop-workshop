require 'crack'
require 'crack/xml'
require 'open-uri'

require_relative 'feed_converter/generator'
require_relative 'feed_converter/parser'
require_relative 'feed_converter/reader'
require_relative 'feed_converter/mutator'

module FeedConverter
  class Converter
    DEFAULTS = {
      format: "rss"
    }

    attr_reader :options
    def initialize(format_options = {})
      @format_options = DEFAULTS.merge(format_options)
    end

    def convert(source, options = {})
      feed_content = Reader.choose(source).read(source)
      parser = Parser.choose(feed_content).new

      feed = parser.parse(feed_content)
      feed[:items] = Mutator.new(options).mutate(feed[:items])

      generator = Generator.choose(@format_options[:format]).new
      generator.generate(feed)
    end
  end
end