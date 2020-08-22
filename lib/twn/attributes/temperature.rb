require 'twn/attribute'
module Twn
  module Attributes
    # The atmosphere of the world
    class Temperature < Twn::Attribute
      self.notation(dice: "2d6")
      Entry = Struct.new(:key, :type)

      TABLE = {
        "F" => Entry.new("F", "Frozen"),
        "C" => Entry.new("C", "Cold"),
        "T" => Entry.new("T", "Temperate"),
        "H" => Entry.new("H", "Hot"),
        "R" => Entry.new("R", "Roasting"),
        "V" => Entry.new("V", "Volatile: Frozen at night, Roasting during day")
      }

      ATMOSPHERE_UWP_MODIFIER = {
        "2" => -2,
        "3" => -2,
        "4" => -1,
        "5" => -1,
        "E" => -1,
        "8" => 1,
        "9" => 1,
        "A" => 2,
        "D" => 2,
        "F" => 2,
        "B" => 6,
        "C" => 6
      }


      def self.roll!(generator:, table: TABLE)
        key = case generator.uwp_for(:Size)
              when "0", "1" then "V"
              else
                atmosphere = generator.fetch(:Atmosphere)
                roll = generator.roll(notation) + ATMOSPHERE_UWP_MODIFIER.fetch(atmosphere.to_uwp, 0)
                case roll
                when (-10..2) then "F"
                when (3..4) then "C"
                when (5..9) then "T"
                when (10..11) then "H"
                when (12..30) then "R"
                end
              end
        entry = table.fetch(key)
        new(entry: entry)
      end

      def initialize(entry:)
        @entry = entry
      end

      # Convert to Universal World Profile (UWP) element.
      def to_uwp
        @entry.key
      end
    end
  end
end
