require 'twn/attribute'
module Twn
  module Attributes
    # The Travel Code for the world
    class TravelCode < Twn::Attribute
      NO = ""
      AMBER = "A"
      RED = "R"
      initialize_table do
        add_row(roll: NO, description: "No travel code")
        add_row(roll: AMBER, description: "Amber travel code")
        add_row(roll: RED, description: "Red travel code")
      end

      def self.roll!(generator:)
        # I decided that Red travel advisories should be rare (1/36)
        # chance.  And I may as well make these random.
        return build(roll: RED) if Utility.roll("2d6") == 12
        return build(roll: AMBER) if generator.get!(:Atmosphere).roll > 10
        return build(roll: AMBER) if [0,7,10].include?(generator.get!(:Government).roll)
        law = generator.get!(:LawLevel)
        return build(roll: AMBER) if law.roll == 0 || law.roll >= 9
        build(roll: NO)
      end
    end
  end
end
