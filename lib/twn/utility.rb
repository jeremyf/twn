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
      # @param value [String,Integer]
      #
      # @return String
      def to_uwp(value)
        case value
        when String then value.upcase
        when Integer then sprintf("%X",value)
        end
      end
    end
  end
end
