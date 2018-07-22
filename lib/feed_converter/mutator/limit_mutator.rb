module FeedConverter
  class LimitMutator
    def initialize(options = {})
      @limit = options.fetch(:limit, 10)
    end

    def mutate(items)
      items[0..@limit] if @limit
    end
  end
end

