require 'twn/attribute'
module Twn
  module Attributes
    # Gas Giant!
    class GasGiant < Twn::Attribute
      initialize_table do |table|
        table.add_row(roll: "", description: "No gas giant")
        table.add_row(roll: "G", description: "Gas giant")
      end

      # @param generator [Twn::Generator]
      # @param table [Hash<String, Entry>]
      def self.roll!(generator:)
        roll = Utility.roll("2d6") < 10 ? "" : "G"
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
    end
  end
end
