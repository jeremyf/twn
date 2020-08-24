require "twn/table"
require "twn/utility"
module Twn
  class Attribute
    def self.initialize_table(&block)
      @table ||= Table.new(attribute_name: attribute_name, &block)
    end

    def self.attribute_name
      to_s.split("::")[-1].to_sym
    end

    def attribute_name
      self.class.attribute_name
    end

    def self.build(roll:)
      row = @table.fetch_by_roll(roll)
      new(entry: row)
    end

    def self.fetch_by_uwp_slug(uwp_slug)
      @table.fetch_by_uwp_slug(uwp_slug)
    end

    def self.roll!(generator:,**)
      raise "#{self} must implement .#{__method__}"
    end

    def initialize(entry:)
      @entry = entry
    end


    extend Forwardable
    def_delegators :@entry, :to_uwp_slug, :roll
  end
end
