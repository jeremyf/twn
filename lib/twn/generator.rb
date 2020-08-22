module Twn
  class Generator
    def initialize
      @generated_attributes = {}
    end

    NOTATION_TO_DICE_ROLLER_MAP = {
      "2d6" => -> { rand(6) + rand(6) + 2 }
    }
    def roll(notation, modifier, plus: [], minus: [])
      dice_roller = NOTATION_TO_DICE_ROLLER_MAP.fetch(notation, notation)
      result = dice_roller.call + modifier
      Array(plus).each do |attr|
        @generated_attributes[attr] ||= Attributes.roll(on: attr, generator: self)
        result += @generated_attributes[attr].to_i
      end
      result
    end
  end
end
