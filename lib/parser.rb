require_relative 'parser/atom_parser'
require_relative 'parser/rss_parser'

module ItemsHelper
  def self.create(data)
    Item.new(
      data.fetch("title"),
      data.fetch("description"),
      data.fetch("pubDate"),
      data.fetch("link"),
      data.fetch("guid"),
    )
  end

  def self.strip_out_guids(items)
    items.each{|el| el.guid = nil}
  end
end

module Parser
  def self.choose(content)
    #FIXME: stupid lazy detector for now
    regexp = Regexp.new('<rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom">')
    content =~ regexp ? AtomParser : RssParser
  end
end
