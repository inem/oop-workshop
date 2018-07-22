require 'date'

module FeedConverter
  class SortMutator
    def initialize(options = {})
      @field = options == true ? :date : options.fetch(:field, :date)
    end

    def mutate(items)
      if @field == :date
        items.sort{|a, b| to_date(a[@field]) <=> to_date(b[@field]) }
      else
        items.sort{|a, b| a[@field] <=> b[@field] }
      end
    end

    def to_date(a)
      DateTime.parse(a).to_date
    end
  end
end

