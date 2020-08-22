require 'twn/attribute'
module Twn
  module Attributes
    # The research base for the world
    class ResearchBase < Twn::Attribute
      Entry = Struct.new(:to_uwp, :description)
      NO_RESEARCH_BASE = Entry.new("", "No research base")
      RESEARCH_BASE = Entry.new("S", "Research base")

      def self.roll!(generator:)
        roll = generator.roll("2d6")
        entry = entry_for(roll: roll, generator: generator)
        new(entry: entry)
      end

      def self.entry_for(roll:, generator:)
        case generator.uwp_for(:Starport)
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

      def to_uwp
        @entry.to_uwp
      end
    end
  end
end
