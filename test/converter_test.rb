require_relative 'test_helper'
require_relative '../lib/converter'
require 'open-uri'

dir = File.expand_path File.dirname(__FILE__)

class ConverterTest < Minitest::Test
  def test_reader_chooser
    assert { Reader.choose("https://yandex.ru/feed.rss") == HttpReader }
    assert { Reader.choose("http://yandex.ru/feed.rss") == HttpReader }
    assert { Reader.choose("file.xml") == FileReader }
    assert { Reader.choose("httpfile.rss") == FileReader }
  end

  def test_parser_chooser
    rss = IO.read("#{__dir__}/files/feed.rss")
    atom = open("https://ru.hexlet.io/lessons.rss").read

    assert { Parser.choose(rss) == RssParser }
    assert { Parser.choose(atom) == AtomParser }
  end

  def test_converter_runs_without_errors
    options = {
      reverse: false,
      sort: false,
      format: "rss",
      limit: false
    }

    output = Converter.new(options).convert("#{__dir__}/files/feed.rss")
    output = Converter.new(options.merge(format: "atom")).convert("https://ru.hexlet.io/lessons.rss")
  end
end