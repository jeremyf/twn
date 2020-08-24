require 'twn/attribute'
module Twn
  module Attributes
    # The starport of the world
    class Starport < Twn::Attribute
      initialize_table do |table|
        table.add_row(roll: 2, to_uwp_slug: "X", description: "No Starport")
        table.add_row(roll: 3, to_uwp_slug: "E", description: "Frontier")
        table.add_row(roll: 4, to_uwp_slug: "E", description: "Frontier")
        table.add_row(roll: 5, to_uwp_slug: "D", description: "Poor")
        table.add_row(roll: 6, to_uwp_slug: "D", description: "Poor")
        table.add_row(roll: 7, to_uwp_slug: "C", description: "Routine")
        table.add_row(roll: 8, to_uwp_slug: "C", description: "Routine")
        table.add_row(roll: 9, to_uwp_slug: "B", description: "Good")
        table.add_row(roll: 10, to_uwp_slug: "B", description: "Good")
        table.add_row(roll: 11, to_uwp_slug: "A", description: "Excellent")
        table.add_row(roll: 12, to_uwp_slug: "A", description: "Excellent")
      end

      def self.roll!(generator:)
        roll = Utility.roll("2d6")
        build(roll: roll)
      end
    end
  end
end
