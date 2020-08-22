require 'twn/attribute'
module Twn
  module Attributes
    # The government of the world
    class Government < Twn::Attribute
      self.notation("2d6", -7)
      Entry = Struct.new(:key, :type)

      self.table = {
        0 => Entry.new(0, "None"),
        1 => Entry.new(1, "Company/corporation"),
        2 => Entry.new(2, "Participating democracy"),
        3 => Entry.new(3, "Self-perpetuating oligarchy"),
        4 => Entry.new(4, "Representative democracys"),
        5 => Entry.new(5, "Feudal technocracy"),
        6 => Entry.new(6, "Captive government"),
        7 => Entry.new(7, "Balkanisation"),
        8 => Entry.new(8, "Civil service bureaucracy"),
        9 => Entry.new(9, "Impersonal bureaucracy"),
        10 => Entry.new(10, "Charismatic dictator"),
        11 => Entry.new(11, "Non-charismatic leaderdictator"),
        12 => Entry.new(12, "Charismatic oligarchy"),
        13 => Entry.new(13, "Religious dictatorship")
      }

      # @param generator [Twn::Generator]
      # @param table [Hash<Integer, Entry>]
      def self.roll!(generator:)
        population = generator.fetch(:Population)
        if population.to_i == 0
          build(roll: 0)
        else
          roll = generator.roll(*notation) + population.to_i
          build(roll: roll)
        end
      end
    end
  end
end
