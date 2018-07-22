require_relative 'reader/file_reader'
require_relative 'reader/http_reader'

module Reader
  def self.choose(source)
    source =~ /^https?\:\// ? HttpReader : FileReader
  end
end