require_relative 'test_helper'
require_relative '../lib/entities'
require_relative '../lib/converter'

dir = File.expand_path File.dirname(__FILE__)

class ConverterTest < Minitest::Test
  def test_reader_chooser
    assert { ReaderChooser.choose("https://yandex.ru/feed.rss") == HttpReader }
    assert { ReaderChooser.choose("http://yandex.ru/feed.rss") == HttpReader }
    assert { ReaderChooser.choose("file.xml") == FileReader }
    assert { ReaderChooser.choose("httpfile.rss") == FileReader }
  end

  def test_parser_chooser
    assert { ParserChooser.choose("rss") == RssParser }
    assert { ParserChooser.choose("atom") == AtomParser }
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