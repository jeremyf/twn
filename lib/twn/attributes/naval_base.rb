require 'twn/attribute'
module Twn
  module Attributes
    # The naval base for the world
    class NavalBase < Twn::Attribute
      Entry = Struct.new(:to_uwp_slug, :description)
      NO_NAVAL_BASE = Entry.new("", "No naval base")
      NAVAL_BASE = Entry.new("N", "Naval Base")

      def self.roll!(generator:)
        roll = Utility.roll("2d6")
        entry = entry_for(roll: roll, generator: generator)
        new(entry: entry)
      end

      def self.entry_for(roll:, generator:)
        case generator.uwp_slug_for(:Starport)
        when "A"
          roll < 8 ? NO_NAVAL_BASE : NAVAL_BASE
        when "B"
          roll < 8 ? NO_NAVAL_BASE : NAVAL_BASE
        when "C"
          NO_NAVAL_BASE
        when "D"
          NO_NAVAL_BASE
        when "E"
          NO_NAVAL_BASE
        when "X"
          NO_NAVAL_BASE
        end
      end

      def to_uwp_slug
        @entry.to_uwp_slug
      end
    end
  end
end
