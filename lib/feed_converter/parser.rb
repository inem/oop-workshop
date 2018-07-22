require_relative 'parser/item_helper'
require_relative 'parser/atom_parser'
require_relative 'parser/rss_parser'

module FeedConverter
  module Parser
    def self.choose(content)
      #FIXME: stupid lazy detector for now
      regexp = Regexp.new('<rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom">')
      content =~ regexp ? AtomParser : RssParser
    end
  end
end