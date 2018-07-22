require_relative 'test_helper'
require_relative '../lib/converter'
require 'diffy'
require 'open-uri'

dir = File.expand_path File.dirname(__FILE__)

class ConverterTest < Minitest::Test
  def test_converter_atom_to_rss_works_correctly
    output = debeautify Converter.new(format: "rss").convert("#{__dir__}/fixtures/feed.atom")
    expected = debeautify IO.read("#{__dir__}/fixtures/output/feed.atom.rss")

    diff = Diffy::Diff.new(output, expected, :include_diff_info => true).to_s(:text)
    puts diff if diff != ""
    assert { diff == "" }
  end

  def test_converter_rss_to_atom_works_correctly
    output =  debeautify Converter.new(format: "atom").convert("#{__dir__}/fixtures/feed.rss")
    expected = debeautify IO.read("#{__dir__}/fixtures/output/feed.rss.atom")

    diff = Diffy::Diff.new(output, expected, :include_diff_info => true).to_s(:text)
    puts diff if diff != ""
    assert { diff == "" }
  end

  def debeautify(xml)
    xml.gsub(/>\s*</, ">\n<")
  end
end