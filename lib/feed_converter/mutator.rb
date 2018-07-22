module FeedConverter
  class Mutator
    DEFAULTS = {
      sort: false,
      reverse: false,
      limit: false
    }

    MUTATIONS = {
      sort: -> (items, _){ items.sort{|a,b| a[:date] <=> b[:date] } },
      reverse: -> (items){ items.reverse },
      limit: -> (items, n){ items[0...n] }
    }

    def initialize(options)
      @options = DEFAULTS.merge(options)
    end

    def mutate(list)
      items = list
      @options.each do |option, value|
        items = MUTATIONS[option].call(items, value) if value
      end
      items
    end
  end
end