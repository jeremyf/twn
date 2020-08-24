require 'twn/attribute'
module Twn
  module Attributes
    # The naval base for the world
    class PirateBase < Twn::Attribute
      NO = ""
      YES = "P"
      initialize_table do
        add_row(roll: NO, description: "No pirate base")
        add_row(roll: YES, description: "Pirate base")
      end

      def self.roll!(generator:)
        roll = case Utility.to_uwp_slug(generator.get!(:Starport))
               when "A", "X"
                 NO
               when "B", "D", "E"
                 Utility.roll("2d6") < 12 ? NO : YES
               when "C"
                 Utility.roll("2d6") < 10 ? NO : YES
               end
        build(roll: roll)
      end
    end
  end
end
