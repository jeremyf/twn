require 'twn/attribute'
module Twn
  module Attributes
    # The government of the world
    class Government < Twn::Attribute
      initialize_table do |table|
        table.add_row(roll: 0, type: "None")
        table.add_row(roll: 1, type: "Company/corporation")
        table.add_row(roll: 2, type: "Participating democracy")
        table.add_row(roll: 3, type: "Self-perpetuating oligarchy")
        table.add_row(roll: 4, type: "Representative democracys")
        table.add_row(roll: 5, type: "Feudal technocracy")
        table.add_row(roll: 6, type: "Captive government")
        table.add_row(roll: 7, type: "Balkanisation")
        table.add_row(roll: 8, type: "Civil service bureaucracy")
        table.add_row(roll: 9, type: "Impersonal bureaucracy")
        table.add_row(roll: 10, type: "Charismatic dictator")
        table.add_row(roll: 11, type: "Non-charismatic leaderdictator")
        table.add_row(roll: 12, type: "Charismatic oligarchy")
        table.add_row(roll: 13, type: "Religious dictatorship")
      end

      # @param generator [Twn::Generator]
      # @param table [Hash<Integer, Entry>]
      def self.roll!(generator:)
        population = generator.get!(:Population)
        if population.roll == 0
          build(roll: 0)
        else
          roll = Utility.roll("2d6", -7) + population.roll
          build(roll: roll)
        end
      end
    end
  end
end
