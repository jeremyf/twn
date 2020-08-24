require 'twn/attribute'
module Twn
  module Attributes
    # The naval base for the world
    class NavalBase < Twn::RefactoredAttribute
      NO = ""
      YES = "N"
      initialize_table do |table|
        table.add_row(roll: NO, description: "No naval base")
        table.add_row(roll: YES, description: "Naval base")
      end

      def self.roll!(generator:)
        roll = case Utility.to_uwp_slug(generator.get!(:Starport))
               when "A"
                 Utility.roll("2d6") < 8 ? NO : YES
               when "B"
                 Utility.roll("2d6") < 8 ? NO : YES
               when "C", "D", "E", "X"
                 NO
               end

        build(roll: roll)
      end
    end
  end
end
