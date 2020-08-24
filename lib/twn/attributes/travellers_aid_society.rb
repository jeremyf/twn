require 'twn/attribute'
module Twn
  module Attributes
    # The Traveller's Aid Society for the world
    class TravellersAidSociety < Twn::Attribute
      NO = ""
      YES = "T"
      initialize_table do
        add_row(roll: NO, description: "No Traveller's Aid Society")
        add_row(roll: YES, description: "Traveller's Aid Society")
      end

      def self.roll!(generator:)
        roll = case Utility.to_uwp_slug(generator.get!(:Starport))
               when "A"
                 Utility.roll("2d6") < 4 ? NO : YES
               when "B"
                 Utility.roll("2d6") < 6 ? NO : YES
               when "C"
                 Utility.roll("2d6") < 10 ? NO : YES
               when "D", "E", "X"
                 NO
               end
        build(roll: roll)
      end
    end
  end
end
