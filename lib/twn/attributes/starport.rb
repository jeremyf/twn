require 'twn/attribute'
module Twn
  module Attributes
    # The starport of the world
    class Starport < Twn::Attribute
      Entry = Struct.new(:to_uwp, :quality)
      X = Entry.new("X", "No Starport")
      A = Entry.new("A", "Excellent")
      B = Entry.new("B", "Good")
      C = Entry.new("C", "Routine")
      D = Entry.new("D", "Poor")
      E = Entry.new("E", "Frontier")
      self.table = {
        2 => X,
        3 => E,
        4 => E,
        5 => D,
        6 => D,
        7 => C,
        8 => C,
        9 => B,
        10 => B,
        11 => A
      }

      def self.roll!(generator:)
        roll = generator.roll("2d6")
        build(roll: roll)
      end

      def to_uwp
        @entry.to_uwp
      end
    end
  end
end
