require 'twn/attribute'
module Twn
  module Attributes
    # The atmosphere of the world
    class Atmosphere < Twn::Attribute
      # 2d6-7 + Planet Size
      Entry = Struct.new(:key, :atomosphere)

      TABLE = {
        0 => Entry.new(0, "None"),
        1 => Entry.new(1, "Trace"),
        2 => Entry.new(2, "Very Thin, Tainted"),
        3 => Entry.new(3, "Very Thin"),
        4 => Entry.new(4, "Thin, Tainted"),
        5 => Entry.new(5, "Thin"),
        6 => Entry.new(6, "Standard"),
        7 => Entry.new(7, "Standard, Tainted"),
        8 => Entry.new(8, "Dense"),
        9 => Entry.new(9, "Dense, Tainted"),
        10 => Entry.new(10, "Exotic"),
        11 => Entry.new(11, "Corrosive"),
        12 => Entry.new(12, "Insidious"),
        13 => Entry.new(13, "Dense, High"),
        14 => Entry.new(14, "Thin, Low"),
        15 => Entry.new(15, "Unusual")
      }

      def self.roll!(generator:, table: TABLE)
        roll = generator.roll("2d6", -7, plus: :Size)
        entry = table.fetch(roll)
        new(entry: entry)
      end

      def initialize(entry:)
        @entry = entry
      end

      # Convert to Universal World Profile (UWP) element.
      def to_uwp
        sprintf("%X", @entry.key)
      end

      def to_i
        @entry.key
      end
    end
  end
end
