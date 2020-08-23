require 'twn/attribute'
module Twn
  module Attributes
    # Gas Giant!
    class GasGiant < Twn::Attribute
      Entry = Struct.new(:key, :description)
      NO_GIANT = Entry.new("", "No gas giant")
      GIANT = Entry.new("G", "Gas giant")

      self.table = {
        "" => NO_GIANT,
        "G" => GIANT
      }

      # @param generator [Twn::Generator]
      # @param table [Hash<String, Entry>]
      def self.roll!(generator:)
        entry = Utility.roll("2d6") < 10 ? GIANT : NO_GIANT
        new(entry: entry)
      end
    end
  end
end
