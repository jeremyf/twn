require 'twn/attribute'
module Twn
  module Attributes
    # The atmosphere of the world
    class Atmosphere < Twn::Attribute
      initialize_table do |table|
        table.add_row(roll: 0, atmosphere: "None")
        table.add_row(roll: 1, atmosphere: "Trace")
        table.add_row(roll: 2, atmosphere: "Very Thin, Tainted")
        table.add_row(roll: 3, atmosphere: "Very Thin")
        table.add_row(roll: 4, atmosphere: "Thin, Tainted")
        table.add_row(roll: 5, atmosphere: "Thin")
        table.add_row(roll: 6, atmosphere: "Standard")
        table.add_row(roll: 7, atmosphere: "Standard, Tainted")
        table.add_row(roll: 8, atmosphere: "Dense")
        table.add_row(roll: 9, atmosphere: "Dense, Tainted")
        table.add_row(roll: 10, atmosphere: "Exotic")
        table.add_row(roll: 11, atmosphere: "Corrosive")
        table.add_row(roll: 12, atmosphere: "Insidious")
        table.add_row(roll: 13, atmosphere: "Dense, High")
        table.add_row(roll: 14, atmosphere: "Thin, Low")
        table.add_row(roll: 15, atmosphere: "Unusual")
      end

      def self.roll!(generator:)
        roll = Utility.roll("2d6", -7) + generator.get!(:Size).to_i
        build(roll: roll)
      end

      def self.build(roll:)
        row = @refactored_table.fetch_by_roll(roll)
        new(entry: row)
      end

      extend Forwardable
      def_delegators :@entry, :to_uwp_slug

      def key
        @entry.roll
      end
      alias to_i key

    end
  end
end
