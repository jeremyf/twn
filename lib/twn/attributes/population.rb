require 'twn/attribute'
module Twn
  module Attributes
    # The population of the world
    class Population < Twn::Attribute
      self.notation("2d6", -2)
      Entry = Struct.new(:key, :population, :range)

      self.table = {
        0 => Entry.new(0, "None", "0"),
        1 => Entry.new(1, "Few", "1+"),
        2 => Entry.new(2, "Hundreds", "100+"),
        3 => Entry.new(3, "Thousands", "1,000+"),
        4 => Entry.new(4, "Tens of thousands", "10,000+"),
        5 => Entry.new(5, "Hundreds of thousands", "100,000+"),
        6 => Entry.new(6, "Millions", "1,000,000+"),
        7 => Entry.new(7, "Tens of millions", "10,000,000+"),
        8 => Entry.new(8, "Hundreds of millions", "100,000,000+"),
        9 => Entry.new(9, "Billions", "1,000,000,000+"),
        10 => Entry.new(10, "Tens of Billions", "10,000,000,000+"),
      }

      # @param generator [Twn::Generator]
      # @param table [Hash<Integer, Entry>]
      def self.roll!(generator:)
        roll = generator.roll(*notation)
        build(roll: roll)
      end
    end
  end
end
