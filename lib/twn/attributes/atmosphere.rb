require 'twn/attribute'
module Twn
  module Attributes
    # The atmosphere of the world
    class Atmosphere < Twn::Attribute
      initialize_table do
        add_row(roll: 0, atmosphere: "None")
        add_row(roll: 1, atmosphere: "Trace")
        add_row(roll: 2, atmosphere: "Very Thin, Tainted")
        add_row(roll: 3, atmosphere: "Very Thin")
        add_row(roll: 4, atmosphere: "Thin, Tainted")
        add_row(roll: 5, atmosphere: "Thin")
        add_row(roll: 6, atmosphere: "Standard")
        add_row(roll: 7, atmosphere: "Standard, Tainted")
        add_row(roll: 8, atmosphere: "Dense")
        add_row(roll: 9, atmosphere: "Dense, Tainted")
        add_row(roll: 10, atmosphere: "Exotic")
        add_row(roll: 11, atmosphere: "Corrosive")
        add_row(roll: 12, atmosphere: "Insidious")
        add_row(roll: 13, atmosphere: "Dense, High")
        add_row(roll: 14, atmosphere: "Thin, Low")
        add_row(roll: 15, atmosphere: "Unusual")
      end

      def self.roll!(generator:)
        roll = Utility.roll("2d6", -7) + generator.get!(:Size).roll
        build(roll: roll)
      end
    end
  end
end
