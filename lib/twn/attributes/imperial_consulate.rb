require 'twn/attribute'
module Twn
  module Attributes
    # The Imperial Consulate for the world
    class ImperialConsulate < Twn::RefactoredAttribute
      initialize_table do |table|
        table.add_row(roll: "", description: "No Imperial Consulate")
        table.add_row(roll: "C", description: "Imperial Consulate")
      end

      def self.roll!(generator:)
        roll = case Utility.to_uwp_slug(generator.get!(:Starport))
               when "A"
                 Utility.roll("2d6") < 6 ? "" : "C"
               when "B"
                 Utility.roll("2d6") < 8 ? "" : "C"
               when "C"
                 Utility.roll("2d6") < 10 ? "" : "C"
               when "D"
                 ""
               when "E"
                 ""
               when "X"
                 ""
               end

        build(roll: roll)
      end
    end
  end
end
