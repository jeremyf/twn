require 'twn/attribute'
module Twn
  module Attributes
    # The research base for the world
    class ResearchBase < Twn::Attribute
      Entry = Struct.new(:to_uwp_slug, :description)
      NO_RESEARCH_BASE = Entry.new("", "No research base")
      RESEARCH_BASE = Entry.new("S", "Research base")

      def self.roll!(generator:)
        roll = Utility.roll("2d6")
        entry = entry_for(roll: roll, generator: generator)
        new(entry: entry)
      end

      def self.entry_for(roll:, generator:)
        case generator.uwp_slug_for(:Starport)
        when "A"
          roll < 8 ? NO_RESEARCH_BASE : RESEARCH_BASE
        when "B"
          roll < 10 ? NO_RESEARCH_BASE : RESEARCH_BASE
        when "C"
          roll < 10 ? NO_RESEARCH_BASE : RESEARCH_BASE
        when "D"
          NO_RESEARCH_BASE
        when "E"
          NO_RESEARCH_BASE
        when "X"
          NO_RESEARCH_BASE
        end
      end

      def to_uwp_slug
        @entry.to_uwp_slug
      end
    end
  end
end
