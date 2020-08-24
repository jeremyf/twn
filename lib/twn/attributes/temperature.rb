require 'twn/attribute'
module Twn
  module Attributes
    # The atmosphere of the world
    class Temperature < Twn::Attribute
      initialize_table do
        add_row(roll: "F", type: "Frozen")
        add_row(roll: "C", type: "Cold")
        add_row(roll: "T", type: "Temperate")
        add_row(roll: "H", type: "Hot")
        add_row(roll: "R", type: "Roasting")
        add_row(roll: "V", type: "Volatile: Frozen at night, Roasting during day")
      end

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

      def self.roll!(generator:)
        key = case Utility.to_uwp_slug(generator.get!(:Size))
              when "0", "1" then "V"
              else
                atmosphere = generator.get!(:Atmosphere)
                roll = Utility.roll("2d6") + ATMOSPHERE_UWP_MODIFIER.fetch(atmosphere.to_uwp_slug, 0)
                case roll
                when (-20..2) then "F"
                when (3..4) then "C"
                when (5..9) then "T"
                when (10..11) then "H"
                when (12..30) then "R"
                end
              end
        build(roll: key)
      end
    end
  end
end
