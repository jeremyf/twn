require 'twn/attribute'
module Twn
  module Attributes
    # The Imperial Consulate for the world
    class ImperialConsulate < Twn::Attribute
      Entry = Struct.new(:to_uwp_slug, :description)
      NO_IMPERIAL_CONSULATE = Entry.new("", "No Imperial Consulate")
      IMPERIAL_CONSULATE = Entry.new("I", "Imperial Consulate")

      def self.roll!(generator:)
        roll = Utility.roll("2d6")
        entry = entry_for(roll: roll, generator: generator)
        new(entry: entry)
      end

      def self.entry_for(roll:, generator:)
        case Utility.to_uwp_slug(generator.get!(:Starport))
        when "A"
          roll < 6 ? NO_IMPERIAL_CONSULATE : IMPERIAL_CONSULATE
        when "B"
          roll < 8 ? NO_IMPERIAL_CONSULATE : IMPERIAL_CONSULATE
        when "C"
          roll < 10 ? NO_IMPERIAL_CONSULATE : IMPERIAL_CONSULATE
        when "D"
          NO_IMPERIAL_CONSULATE
        when "E"
          NO_IMPERIAL_CONSULATE
        when "X"
          NO_IMPERIAL_CONSULATE
        end
      end

      def to_uwp_slug
        @entry.to_uwp_slug
      end
    end
  end
end
