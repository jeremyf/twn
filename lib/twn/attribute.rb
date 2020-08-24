require "twn/table"
require "twn/utility"
module Twn
  class Attribute
    def self.initialize_table(&block)
      @refactored_table ||= Table.new(attribute_name: attribute_name, &block)
    end

    def self.attribute_name
      to_s.split("::")[-1].to_sym
    end

    def attribute_name
      self.class.attribute_name
    end

    def initialize(entry:)
      @entry = entry
    end

    def self.build(roll:)
      row = @refactored_table.fetch_by_roll(roll)
      new(entry: row)
    end

    extend Forwardable
    def_delegators :@entry, :to_uwp_slug

    def key
      @entry.roll
    end
    alias to_i key
  end
end
