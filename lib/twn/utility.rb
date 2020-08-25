module Twn
  # A Utility Module of state-less methods to call
  module Utility
    class << self
      DICE_EXPRESSION_TO_ROLLER_MAP = {
        "1d3" => -> { rand(3) + 1 },
        "2d6" => -> { rand(6) + rand(6) + 2 },
        "1d6" => -> { rand(6) + 1 },
        "1d100" => -> { rand(100) + 1 }
      }

      # Roll the given :dice and add the given :modifier.  If the dice
      # are a registered expression, use the expression.  Otherwise
      # send the dice the #call message.
      #
      # @param dice [String, #call]
      # @param modifier [Integer]
      #
      # @return [Integer] the results of a dice roll
      def roll(dice, modifier = 0, expression_map: DICE_EXPRESSION_TO_ROLLER_MAP)
        dice_roller = expression_map.fetch(dice) { dice }
        dice_roller.call + modifier
      end

      # Return the UWP for the given value
      #
      # @param value [String,Integer, #to_uwp_slug]
      #
      # @return String
      def to_uwp_slug(value)
        return value.to_uwp_slug if value.respond_to?(:to_uwp_slug)
        case value
        when String then value
        when Integer then sprintf("%X",value)
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
