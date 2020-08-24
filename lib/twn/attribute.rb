require "twn/table"
module Twn
  class Attribute

    def self.initialize_table(&block)
      @refactored_table ||= Table.new(attribute_name: attribute_name, &block)
    end

    def self.table=(hash)
      @table = hash
    end

    def self.table
      @table
    end

    def self.build(roll:)
      roll = table.keys.min if table.keys.min > roll
      roll = table.keys.max if table.keys.max < roll
      entry = table.fetch(roll)
      new(entry: entry)
    end

    def self.roll!(generator:)
      raise(NotImplementedError.new("Override .roll! in sub-class"))
    end

    def initialize(entry:)
      @entry = entry
    end

    # Convert to Universal World Profile (UWP) element.
    def to_uwp_slug
      sprintf("%X", @entry.key)
    end

    def key
      @entry.key
    end
    alias to_i key

    def self.attribute_name
      to_s.split("::")[-1].to_sym
    end

    def attribute_name
      self.class.attribute_name
    end
  end
end
