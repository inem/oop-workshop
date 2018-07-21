require_relative 'test_helper'
require_relative '../lib/converter'

class ConverterTest < Minitest::Test
  def test_initialize_with_no_options
    c = Converter.new()
    defaults = {
      reverse: false,
      sort: false,
      format: "rss",
      limit: false
    }
    assert c.options == Converter::DEFAULTS
  end

  def test_initialize_with_options
    options = {sort: true, format: "atom", limit: 3}
    c = Converter.new(options)
    assert c.options == {sort: true, format: "atom", limit: 3, reverse: false}
  end

  def test_reader_chooser
    assert ReaderChooser.choose("https://yandex.ru/feed.rss") == HttpReader
    assert ReaderChooser.choose("file.xml") == FileReader
  end

  def test_parser_chooser
    assert ParserChooser.choose("rss") == RssParser
    assert ParserChooser.choose("atom") == AtomParser
  end
end