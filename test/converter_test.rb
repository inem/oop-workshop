require_relative 'test_helper'
require 'diffy'
require 'open-uri'

dir = File.expand_path File.dirname(__FILE__)

class ShortMutator
  def initialize(options = {})
  end

  def mutate(items)
    items[0..0]
  end
end


class ConverterTest < Minitest::Test
  def test_converter_atom_to_rss_works_correctly
    output = FeedConverter::Converter.new(format: "rss").convert("#{__dir__}/fixtures/feed.atom")
    expected = IO.read("#{__dir__}/fixtures/output/feed.atom.rss")

    assert_xml(output, expected)
  end

  def test_converter_rss_to_atom_works_correctly
    output =  FeedConverter::Converter.new(format: "atom").convert("#{__dir__}/fixtures/feed.rss")
    expected = IO.read("#{__dir__}/fixtures/output/feed.rss.atom")

    assert_xml(output, expected)
  end

  def test_converter_rss_to_atom_works_with_external_mutator
    converter = FeedConverter::Converter.new(format: "atom")
    expected = IO.read("#{__dir__}/fixtures/output/feed_custom_mutator.rss.atom")

    output = converter.convert("#{__dir__}/fixtures/feed.rss", sort: true, custom_mutators: [ShortMutator])
    assert_xml(output, expected)
  end

  def debeautify(xml)
    xml.gsub(/>\s*</, ">\n<")
  end

  def assert_xml(a,b)
    diff = Diffy::Diff.new(debeautify(a), debeautify(b), :include_diff_info => true).to_s(:text)
    puts diff if diff != ""
    assert { diff == "" }
  end
end




