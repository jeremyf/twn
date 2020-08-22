require 'twn/attribute'
module Twn
  module Attributes
    # The Hydrographic characteristics of the planet
    class Hydrographic < Twn::Attribute
      self.notation(dice: "2d6", modifier: -7)
      Entry = Struct.new(:key, :percentage, :description)

      self.table = {
        0 => Entry.new(0, "0%-5%", "Desert world"),
        1 => Entry.new(1, "6%-15%", "Dry world"),
        2 => Entry.new(2, "16%-25%", "A few small seas"),
        3 => Entry.new(3, "25%-35%", "Small seas and oceans"),
        4 => Entry.new(4, "36%-45%", "Wet world"),
        5 => Entry.new(5, "46%-55%", "Large oceans"),
        6 => Entry.new(6, "56%-65%", "Large oceans and seas"),
        7 => Entry.new(7, "66%-75%", "Earth-like world"),
        8 => Entry.new(8, "76%-85%", "Water world"),
        9 => Entry.new(9, "86%-95%", "Only a few small islands and archipelagos"),
        10 => Entry.new(10, "96%-100%", "Almost entirely water.")
      }

      # @param generator [Twn::Generator]
      # @param table [Hash<Integer, Entry>]
      def self.roll!(generator:)
        size = generator.fetch(:Size)
        return build(roll: 0) if ["0","1"].include?(size.to_uwp)
        roll = generator.roll(notation) +
          size.key +
          modifier_for(
            atmoshpere: generator.fetch(:Atmosphere),
            temperature: generator.fetch(:Temperature))
        build(roll: roll)
      end

      def initialize(entry:)
        @entry = entry
      end

      # Convert to Universal World Profile (UWP) element.
      def to_uwp
        sprintf("%X", @entry.key)
      end

      TEMPERATURE_UWP_MODIFIER = {
        "H" => -2,
        "R" => -6,
      }

      ATMOSPHERE_UWP_MODIFIER = {
        "0" => -4,
        "1" => -4,
        "A" => -4,
        "B" => -4,
        "C" => -4,
      }
      def self.modifier_for(atmoshpere:, temperature:)
        modifier = 0
        return modifier if atmoshpere.to_uwp == "D"
        modifier += TEMPERATURE_UWP_MODIFIER.fetch(temperature.to_uwp, 0)
        modifier += ATMOSPHERE_UWP_MODIFIER.fetch(atmoshpere.to_uwp, 0)
        return modifier
      end
    end
  end
end
