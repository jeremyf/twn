require 'twn/attribute'
module Twn
  module Attributes
    # The population of the world
    class Population < Twn::Attribute
      initialize_table do
        add_row(roll: 0, population: "None", range: "0")
        add_row(roll: 1, population: "Few", range: "1+")
        add_row(roll: 2, population: "Hundreds", range: "100+")
        add_row(roll: 3, population: "Thousands", range: "1,000+")
        add_row(roll: 4, population: "Tens of thousands", range: "10,000+")
        add_row(roll: 5, population: "Hundreds of thousands", range: "100,000+")
        add_row(roll: 6, population: "Millions", range: "1,000,000+")
        add_row(roll: 7, population: "Tens of millions", range: "10,000,000+")
        add_row(roll: 8, population: "Hundreds of millions", range: "100,000,000+")
        add_row(roll: 9, population: "Billions", range: "1,000,000,000+")
        add_row(roll: 10, population: "Tens of Billions", range: "10,000,000,000+")
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
