require 'twn/attribute'
module Twn
  module Attributes
    # Gas Giant!
    class GasGiant < Twn::Attribute
      initialize_table do
        add_row(roll: "", description: "No gas giant")
        add_row(roll: "G", description: "Gas giant")
      end

      # @param generator [Twn::Generator]
      # @param table [Hash<String, Entry>]
      def self.roll!(generator:)
        roll = Utility.roll("2d6") < 10 ? "" : "G"
        build(roll: roll)
      end
    end
  end
end
