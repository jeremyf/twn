require 'twn/error'
module Twn
  # A Utility Module of state-less methods to call
  module Utility
    class << self
      DICE_EXPRESSION_TO_ROLLER_MAP = {
        "1d3" => -> { rand(3) + 1 },
        "2d6" => -> { rand(6) + rand(6) + 2 },
        "1d6" => -> { rand(6) + 1 },
        "d66" => -> { "#{rand(6) + 1}#{rand(6) + 1}".to_i },
        "1d100" => -> { rand(100) + 1 },
        "flux"  => -> { rand(6) - rand(6) } # From T5.10
      }

      # Roll the given :dice.  If the dice are a registered
      # expression, use the expression.  Otherwise send the dice the
      # #call message.
      #
      # When you provide a :result_map, any resulting original roll on
      # that are keys in the map are then rolled.
      #
      # @param dice [String, #call]
      # @param expression_map [Hash] used to fetch function for the
      #        given dice expression
      #
      # @return [Integer] the results of a dice roll
      def roll(dice, expression_map: DICE_EXPRESSION_TO_ROLLER_MAP)
        dice_roller = expression_map.fetch(dice) { dice }
        dice_roller.call
      end

      # The extended Hex format of T5.10
      INTEGER_TO_UWP_SLUG = {
        10 => "A",
        11 => "B",
        12 => "C",
        13 => "D",
        14 => "E",
        15 => "F",
        16 => "G",
        17 => "H",
        18 => "J",
        19 => "K",
        20 => "L",
        21 => "M",
        22 => "N",
        23 => "P",
        24 => "Q",
        25 => "R",
        26 => "S",
        27 => "T",
        28 => "U",
        29 => "V",
        30 => "W",
        31 => "X",
        32 => "Y",
        33 => "Z"
      }

      # Return the UWP for the given value
      #
      # @param value [String,Integer, #to_uwp_slug]
      #
      # @return String
      def to_uwp_slug(value)
        return value.to_uwp_slug if value.respond_to?(:to_uwp_slug)
        case value
        when String then value
        when Integer then INTEGER_TO_UWP_SLUG.fetch(value, value).to_s.upcase
        end
      end

      require 'set'
      # This utility method (extracted because its easier to test)
      # will find the intersection of all of the given arrays, and
      # pick a random instance from that array.
      #
      # @param array_of_ranges [Array<Array<String>>]
      # @param pick_on_fail [Boolean] when true, if we have no intersection, pick a candidate.
      def select_random_entry_from_intersection_of(array_of_ranges:, pick_on_fail: false)
        all_candidates = array_of_ranges.flatten
        candidates = Set.new
        intersection = array_of_ranges.shift
        candidates += intersection
        array_of_ranges.each do |range|
          candidates += range
          intersection = intersection & range
        end
        value = intersection.shuffle.first
        return value if value
        return all_candidates.shuffle[0] if pick_on_fail
        raise Twn::Error
      end
    end
  end
end
