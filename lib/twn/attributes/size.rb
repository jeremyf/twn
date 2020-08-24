require 'twn/utility'
require 'twn/attribute'
module Twn
  module Attributes
    # The size of the world
    class Size < Twn::Attribute
      initialize_table do
        add_row(roll: 0, size: 800, surface_gravity: 0, example: "Asteroid, orbital complex")
        add_row(roll: 1, size: 1600, surface_gravity: 0.05, example: "")
        add_row(roll: 2, size: 3200, surface_gravity: 0.15, example: "Triton, Luna, Europa")
        add_row(roll: 3, size: 4800, surface_gravity: 0.25, example: "Mercury, Ganymede")
        add_row(roll: 4, size: 6400, surface_gravity: 0.35, example: "Mars")
        add_row(roll: 5, size: 8000, surface_gravity: 0.45, example: "")
        add_row(roll: 6, size: 9600, surface_gravity: 0.7, example: "")
        add_row(roll: 7, size: 11_200, surface_gravity: 0.9, example: "")
        add_row(roll: 8, size: 12_800, surface_gravity: 1, example: "Earth")
        add_row(roll: 9, size: 14_400, surface_gravity: 1.25, example: "")
        add_row(roll: 10, size: 16_000, surface_gravity: 1.4, example: "")
      end

      # @param generator [Twn::Generator]
      # @param table [Hash<Integer, Entry>]
      def self.roll!(generator:)
        roll = Utility.roll("2d6", -2)
        build(roll: roll)
      end
    end
  end
end
