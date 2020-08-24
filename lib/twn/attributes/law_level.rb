require 'twn/attribute'
module Twn
  module Attributes
    # The Law Level of the world
    class LawLevel < Twn::Attribute
      initialize_table do |table|
        (0..15).each do |i|
          table.add_row(roll: i, description: "Law level #{i}")
        end
      end

      def self.roll!(generator:)
        population = generator.get!(:Population)
        if population.roll == 0
          build(roll: 0)
        else
          roll = Utility.roll("2d6", -7) + generator.get!(:Government).roll
          build(roll: roll)
        end
      end
    end
  end
end
