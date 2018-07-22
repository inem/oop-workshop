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
      @custom_mutators = @options.delete(:custom_mutators) || {}
    end

    def mutate(list)
      items = list

      mutators.each do |mutator, value|
        items = mutator.new(value).mutate(items) if value
      end
      items
    end

    def mutators
      @custom_mutators.merge internal_mutators
    end

    def internal_mutators
      @options.map do |option, value|
        [Object.const_get("FeedConverter::#{option.capitalize}Mutator"), value]
      end.to_h
    end
  end
end