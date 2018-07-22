require 'date'

module FeedConverter
  class SortMutator
    def initialize(options = {})
    end

    def mutate(items)
      items.sort{|a, b| to_date(a[:date]) <=> to_date(b[:date]) }
    end

    def to_date(a)
      DateTime.parse(a).to_date
    end
  end
end

