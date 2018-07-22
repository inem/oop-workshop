require 'builder'
require_relative 'generator/atom_generator'
require_relative 'generator/rss_generator'

module Generator
  def self.choose(format)
    Object.const_get("#{format.capitalize}Generator")
  end
end
