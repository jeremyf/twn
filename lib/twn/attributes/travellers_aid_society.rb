require 'twn/attribute'
module Twn
  module Attributes
    # The Traveller's Aid Society for the world
    class TravellersAidSociety < Twn::Attribute
      Entry = Struct.new(:to_uwp_slug, :description)
      NO_TAS = Entry.new("", "No Traveller's Aid Society")
      TAS = Entry.new("T", "Traveller's Aid Society")

      def self.roll!(generator:)
        roll = Utility.roll("2d6")
        entry = entry_for(roll: roll, generator: generator)
        new(entry: entry)
      end

      def self.entry_for(roll:, generator:)
        case Utility.to_uwp_slug(generator.get!(:Starport))
        when "A"
          roll < 4 ? NO_TAS : TAS
        when "B"
          roll < 6 ? NO_TAS : TAS
        when "C"
          roll < 10 ? NO_TAS : TAS
        when "D"
          NO_TAS
        when "E"
          NO_TAS
        when "X"
          NO_TAS
        end
      end

      def to_uwp_slug
        @entry.to_uwp_slug
      end
    end
  end
end
