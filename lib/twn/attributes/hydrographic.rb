require 'twn/attribute'
module Twn
  module Attributes
    # The Hydrographic characteristics of the planet
    class Hydrographic < Twn::Attribute
      initialize_table do |table|
        table.add_row(roll: 0, percentage:"0%-5%", description: "Desert world")
        table.add_row(roll: 1, percentage:"6%-15%", description: "Dry world")
        table.add_row(roll: 2, percentage:"16%-25%", description: "A few small seas")
        table.add_row(roll: 3, percentage:"25%-35%", description: "Small seas and oceans")
        table.add_row(roll: 4, percentage:"36%-45%", description: "Wet world")
        table.add_row(roll: 5, percentage:"46%-55%", description: "Large oceans")
        table.add_row(roll: 6, percentage:"56%-65%", description: "Large oceans and seas")
        table.add_row(roll: 7, percentage:"66%-75%", description: "Earth-like world")
        table.add_row(roll: 8, percentage:"76%-85%", description: "Water world")
        table.add_row(roll: 9, percentage:"86%-95%", description: "Only a few small islands and archipelagos")
        table.add_row(roll: 10, percentage:"96%-100%", description: "Almost entirely water.")
      end

      # @param generator [Twn::Generator]
      # @param table [Hash<Integer, Entry>]
      def self.roll!(generator:)
        size = generator.get!(:Size)
        return build(roll: 0) if ["0","1"].include?(size.to_uwp_slug)
        roll = Utility.roll("2d6", -7) +
          size.key +
          modifier_for(
            atmoshpere: generator.get!(:Atmosphere),
            temperature: generator.get!(:Temperature))
        build(roll: roll)
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
        return modifier if atmoshpere.to_uwp_slug == "D"
        modifier += TEMPERATURE_UWP_MODIFIER.fetch(temperature.to_uwp_slug, 0)
        modifier += ATMOSPHERE_UWP_MODIFIER.fetch(atmoshpere.to_uwp_slug, 0)
        return modifier
      end
    end
  end
end
