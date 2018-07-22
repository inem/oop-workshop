require_relative 'mutator/limit_mutator'
require_relative 'mutator/reverse_mutator'
require_relative 'mutator/sort_mutator'

module FeedConverter
  class Mutator
    DEFAULTS = {
      sort: false,
      reverse: false,
      limit: false
    }

    def initialize(options)
      @options = DEFAULTS.merge(options)
    end

    def mutate(list)
      items = list

      @options.each do |option, value|
        if value
          mutator_options = @options.select {|key,_| key == option }
          mutator = Object.const_get("FeedConverter::#{option.capitalize}Mutator").new(mutator_options)
          items = mutator.mutate(items)
        end
      end

      items
    end
    private


  end
end