module HttpReader
  def self.read(source)
    open(source).read
  end
end