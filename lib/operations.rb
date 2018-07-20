module Operations
  def self.limit(items, n)
    items[0...n]
  end

  def self.reverse(items)
    items.reverse
  end

  def self.sort(items)
    items.sort{|a,b| a.pubDate <=> b.pubDate}
  end
end