module Twn
  # A Utility Module of state-less methods to call
  module Utility
    class << self
      DICE_EXPRESSION_TO_ROLLER_MAP = {
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
        when String then value.upcase
        when Integer then sprintf("%X",value)
        end
      end

      require 'set'
      # @param array_of_ranges [Array<Array<String>>]
      def select_uwp_slug_from(array_of_ranges:)
        candidates = Set.new
        intersection = array_of_ranges.shift
        candidates += intersection
        array_of_ranges.each do |range|
          candidates += range
          intersection = intersection & range
        end
        value = intersection.shuffle.first
        return value if value
        raise Twn::Error
      end
    end
  end
end
