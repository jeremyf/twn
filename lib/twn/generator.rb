require 'twn/attributes'
module Twn
  class Generator
    def initialize
      @generated_attributes = {}
    end

    def generate(attribute_name)
      build_and_fetch(attribute_name)
    end

    DICE_EXPRESSION_TO_ROLLER_MAP = {
      "2d6" => -> { rand(6) + rand(6) + 2 }
    }

    # @param notation [String, #call]
    # @param modifier [Integer]
    # @param modified_by [Array<Symbol>] an array of attribute names
    def roll(dice:, modifier:, modified_by: [])
      dice_roller = DICE_EXPRESSION_TO_ROLLER_MAP.fetch(dice) { notation }
      result = dice_roller.call + modifier
      Array(modified_by).each do |attribute_name|
        result += yield(build_and_fetch(attribute_name))
      end
      result
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
