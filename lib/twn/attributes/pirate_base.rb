require 'twn/attribute'
module Twn
  module Attributes
    # The Pirate Base for the world
    class PirateBase < Twn::Attribute
      Entry = Struct.new(:to_uwp, :description)
      NO_PIRATE_BASE = Entry.new("", "No pirate base")
      PIRATE_BASE = Entry.new("P", "Pirate base")

      def self.roll!(generator:)
        roll = generator.roll("2d6")
        entry = entry_for(roll: roll, generator: generator)
        new(entry: entry)
      end

      def self.entry_for(roll:, generator:)
        case generator.uwp_for(:Starport)
        when "A"
          NO_PIRATE_BASE
        when "B"
          roll < 12 ? NO_PIRATE_BASE : PIRATE_BASE
        when "C"
          roll < 10 ? NO_PIRATE_BASE : PIRATE_BASE
        when "D"
          roll < 12 ? NO_PIRATE_BASE : PIRATE_BASE
        when "E"
          roll < 12 ? NO_PIRATE_BASE : PIRATE_BASE
        when "X"
          NO_PIRATE_BASE
        end
      end

      def to_uwp
        @entry.to_uwp
      end
    end
  end
end
