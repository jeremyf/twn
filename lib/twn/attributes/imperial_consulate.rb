require 'twn/attribute'
module Twn
  module Attributes
    # The Imperial Consulate for the world
    class ImperialConsulate < Twn::Attribute
      NO = ""
      YES = "C"
      initialize_table do |table|
        table.add_row(roll: NO, description: "No Imperial Consulate")
        table.add_row(roll: YES, description: "Imperial Consulate")
      end

      def self.roll!(generator:)
        roll = case Utility.to_uwp_slug(generator.get!(:Starport))
               when "A"
                 Utility.roll("2d6") < 6 ? NO : YES
               when "B"
                 Utility.roll("2d6") < 8 ? NO : YES
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
