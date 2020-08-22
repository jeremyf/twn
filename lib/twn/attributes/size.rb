require 'twn/attribute'
module Twn
  module Attributes
    # The size of the world
    class Size < Twn::Attribute
      self.notation("2d6", -2)
      Entry = Struct.new(:key, :entry, :size, :surface_gravity, :example)

      TABLE = {
        0 => Entry.new(0, 800, 0, "Asteroid, orbital complex"),
        1 => Entry.new(1, 1600, 0.05, ""),
        2 => Entry.new(2, 3200, 0.15, "Triton, Luna, Europa"),
        3 => Entry.new(3, 4800, 0.25, "Mercury, Ganymede"),
        4 => Entry.new(4, 6400, 0.35, "Mars"),
        5 => Entry.new(5, 8000, 0.45, ""),
        6 => Entry.new(6, 9600, 0.7, ""),
        7 => Entry.new(7, 11_200, 0.9, ""),
        8 => Entry.new(8, 12_800, 1, "Earth"),
        9 => Entry.new(9, 14_400, 1.25, ""),
        10 => Entry.new(10, 16_000, 1.4, "")
      }

      # @param generator [Twn::Generator]
      # @param table [Hash<Integer, Entry>]
      def self.roll!(generator:, table: TABLE)
        roll = generator.roll(*notation)
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
    end
  end
end