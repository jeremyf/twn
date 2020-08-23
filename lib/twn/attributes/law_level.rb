require 'twn/attribute'
module Twn
  module Attributes
    # The Law Level of the world
    class LawLevel < Twn::Attribute
      Entry = Struct.new(:key, :level)
      a_table = {}
      (0..15).each do |i|
        a_table[i] = Entry.new(i, "Level #{i}")
      end
      self.table = a_table

      def self.roll!(generator:)
        population = generator.get!(:Population)
        if population.to_i == 0
          build(roll: 0)
        else
          roll = Utility.roll("2d6", -7) + generator.get!(:Government).to_i
          build(roll: roll)
        end
      end
    end
  end
end
