module Operations
  def self.limit(items, n)
    items[0...n]
  end

  def self.reverse(items)
    items.reverse
  end

  def self.sort(items, sort_method)
    items.sort{|a,b| sort_method.call(a,b) }
  end
end