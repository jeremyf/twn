require 'twn/attributes'
module Twn
  # This class manages the state of a generated world.
  class Generator
    def initialize
      @generated_attributes = {}
    end

    def generate(attribute_name)
      build_and_fetch(attribute_name)
    end
    alias fetch generate

    DICE_EXPRESSION_TO_ROLLER_MAP = {
      "2d6" => -> { rand(6) + rand(6) + 2 }
    }

    # @param notation [String, #call]
    # @param modifier [Integer]
    def roll(dice, modifier = 0)
      dice_roller = DICE_EXPRESSION_TO_ROLLER_MAP.fetch(dice) { notation }
      dice_roller.call + modifier
    end

    def uwp_for(attribute_name)
      build_and_fetch(attribute_name).to_uwp
    end

    private

    def build_and_fetch(attribute_name)
      @generated_attributes[attribute_name] ||= Attributes.roll(on: attribute_name, generator: self)
      @generated_attributes.fetch(attribute_name)
    end
  end
end
