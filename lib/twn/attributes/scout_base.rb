require 'twn/attribute'
module Twn
  module Attributes
    # The scout base for the world
    class ScoutBase < Twn::Attribute
      NO = ""
      YES = "S"
      initialize_table do
        add_row(roll: NO, description: "No scout base")
        add_row(roll: YES, description: "Scout base")
      end

      def self.roll!(generator:)
        roll = case Utility.to_uwp_slug(generator.get!(:Starport))
               when "A"
                 Utility.roll("2d6") < 10 ? NO : YES
               when "B", "C"
                 Utility.roll("2d6") < 8 ? NO : YES
               when "D"
                 Utility.roll("2d6") < 7 ? NO : YES
               when "E", "X"
                 NO
               end
        build(roll: roll)
      end
    end
  end
end
