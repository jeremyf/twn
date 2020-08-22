module Twn
  class Generator
    def initialize
      @generated_attributes = {}
    end

    NOTATIONS = {
      "2d6" => -> { rand(6) + rand(6) +2 }
    }
    def roll(notation, modifier, plus: [], minus: [])
      notation = NOTATIONS.fetch(notation, notation)
      Array(plus).map do |attr|
        @generated_attributes[attr] ||= Attributes.roll(on: attr, generator: self)
      end
    end
  end
end
