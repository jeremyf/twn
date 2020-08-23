require 'twn/attribute'
module Twn
  module Attributes
    # The Travel Code for the world
    class TravelCode < Twn::Attribute
      Entry = Struct.new(:to_uwp_slug, :description)
      NONE = Entry.new("", "No travel code")
      AMBER = Entry.new("A", "Amber travel code")
      RED = Entry.new("R", "Red travel code")

      def self.roll!(generator:)
        # I decided that Red travel advisories should be rare (1/36)
        # chance.  And I may as well make these random.
        return new(entry: RED) if Utility.roll("2d6") == 12
        return new(entry: AMBER) if generator.get!(:Atmosphere).to_i > 10
        return new(entry: AMBER) if [0,7,10].include?(generator.get!(:Government).to_i)
        law = generator.get!(:LawLevel).to_i
        return new(entry: AMBER) if law == 0 || law >= 9
        new(entry: NONE)
      end

      def to_uwp_slug
        @entry.to_uwp_slug
      end
    end
  end
end
