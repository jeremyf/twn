require "twn/table"
require "twn/utility"
module Twn
  class Attribute
    def self.attribute_name
      to_s.split("::")[-1].to_sym
    end

    def self.fetch_by_uwp_slug(uwp_slug)
      new(entry: @table.fetch_by_uwp_slug(uwp_slug))
    end

    # @param entry [Twn::Table::Row]
    def initialize(entry:, attribute_name: self.class.attribute_name)
      @entry = entry
      @attribute_name = attribute_name
    end

    attr_reader :attribute_name

    extend Forwardable
    def_delegators :@entry, :to_uwp_slug, :roll, :constraints
  end

  # Some attributes (e.g. Trade Codes and SWN tags) are an Array of
  # entries I need to be able to render the container as a
  # "to_uwp_code" which would join each elements "to_uwp_code".  I
  # would also need "fetch_by_uwp_code" to rebuild a composite based
  # on the joined "to_uwp_code";  Likewise for roll.
  class CompositeAttribute < Attribute
    UWP_SLUG_JOIN_CHARACTER = " "

    def self.fetch_by_uwp_slug(uwp_slug)
      entries = uwp_slug.split(UWP_SLUG_JOIN_CHARACTER).map do |uwp_slug|
        @table.fetch(uwp_slug_range)
      end
      new(entries: entries)
    end

    # @param entry [Array<Twn::Table::Row>]
    def initialize(entries:, attribute_name: self.class.attribute_name)
      @entries = Array(entries)
      @attribute_name = attribute_name
    end

    def constraints
      @entries.map(&:constraints).flatten
    end

    def to_uwp_slug
      @entries.map(&:to_uwp_slug).join(UWP_SLUG_JOIN_CHARACTER)
    end

    def roll
      @entries.map(&:roll)
    end
  end
end
