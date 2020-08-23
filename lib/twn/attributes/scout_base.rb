require 'twn/attribute'
module Twn
  module Attributes
    # The scout base for the world
    class ScoutBase < Twn::Attribute
      Entry = Struct.new(:to_uwp_slug, :description)
      NO_SCOUT_BASE = Entry.new("", "No scout base")
      SCOUT_BASE = Entry.new("S", "Scout base")

      def self.roll!(generator:)
        roll = Utility.roll("2d6")
        entry = entry_for(roll: roll, generator: generator)
        new(entry: entry)
      end

      def self.entry_for(roll:, generator:)
        case generator.uwp_slug_for(:Starport)
        when "A"
          roll < 10 ? NO_SCOUT_BASE : SCOUT_BASE
        when "B"
          roll < 8 ? NO_SCOUT_BASE : SCOUT_BASE
        when "C"
          roll < 8 ? NO_SCOUT_BASE : SCOUT_BASE
        when "D"
          roll < 7 ? NO_SCOUT_BASE : SCOUT_BASE
        when "E"
          NO_SCOUT_BASE
        when "X"
          NO_SCOUT_BASE
        end
      end

      def to_uwp_slug
        @entry.to_uwp_slug
      end
    end
  end
end
