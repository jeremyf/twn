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
