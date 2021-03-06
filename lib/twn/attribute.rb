require 'forwardable'
module Twn
  class Attribute
    def self.fetch_by_uwp_slug(uwp_slug)
      new(entry: @table.fetch_by_uwp_slug(uwp_slug))
    end

    # @param entry [Twn::Table::Row]
    def initialize(entry:, name:)
      @entry = entry
      @name = name
    end

    attr_reader :name

    extend Forwardable
    def_delegators :@entry, :to_uwp_slug, :roll, :constraints

    def to_a
      Array(@entry.to_uwp_slug)
    end
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
        @table.fetch_by_uwp_slug(uwp_slug_range)
      end
      new(entries: entries)
    end

    # @param entry [Array<Twn::Table::Row>]
    def initialize(entries:, name:)
      @entries = Array(entries)
      @name = name
    end

    def constraints
      @entries.map(&:constraints).flatten
    end

    def to_uwp_slug
      @entries.map(&:to_uwp_slug).join(UWP_SLUG_JOIN_CHARACTER)
    end

    def to_a
      @entries.map(&:to_uwp_slug)
    end

    def roll
      @entries.map(&:roll)
    end
  end
end
