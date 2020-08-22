module Twn
  class Generator
    def initialize
      @generated_attributes = {}
    end

    NOTATION_TO_DICE_ROLLER_MAP = {
      "2d6" => -> { rand(6) + rand(6) + 2 }
    }
    # @param notation [String, #call]
    # @param modifier [Integer]
    # @param modified_by [Array<Symbol>] an array of attribute names
    def roll(notation, modifier, modified_by: [])
      dice_roller = NOTATION_TO_DICE_ROLLER_MAP.fetch(notation) { notation }
      result = dice_roller.call + modifier
      Array(modified_by).each do |attribute_name|
        @generated_attributes[attribute_name] ||= Attributes.roll(on: attribute_name, generator: self)
        result += yield(@generated_attributes[attribute_name])
      end
      result
    end
  end
end
