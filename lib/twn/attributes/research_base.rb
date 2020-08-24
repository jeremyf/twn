require 'twn/attribute'
module Twn
  module Attributes
    # The research base for the world
    class ResearchBase < Twn::Attribute
      NO = ""
      YES = "R"
      initialize_table do
        add_row(roll: NO, description: "No research base")
        add_row(roll: YES, description: "Research base")
      end

      def self.roll!(generator:)
        roll = case Utility.to_uwp_slug(generator.get!(:Starport))
               when "B", "C"
                 Utility.roll("2d6") < 10 ? NO : YES
               when "A"
                 Utility.roll("2d6") < 8 ? NO : YES
               when "D", "E", "X"
                 NO
               end
        build(roll: roll)
      end
    end
  end
end
