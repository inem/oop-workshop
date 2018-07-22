module FeedConverter
  class ReverseMutator
    def initialize(options = {})
    end

    def mutate(items)
      items.reverse
    end
  end
end

