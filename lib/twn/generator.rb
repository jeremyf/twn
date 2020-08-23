require 'twn/attributes'
require 'twn/constraint'
module Twn
  # This class manages the state of a generated world.
  class Generator
    def initialize
      @generated_attributes = {}
      @constraints = []
    end

    # @see Twn::Constraint
    def add_constraint!(applies_to:, uwp_slug_range:)
      @constraints << Constraint.new(applies_to: applies_to, uwp_slug_range: uwp_slug_range, state: self)
    end

    def generate(attribute_name)
      build_and_fetch(attribute_name)
    end
    alias get! generate

    def uwp_slug_for(attribute_name)
      build_and_fetch(attribute_name).to_uwp_slug
    end

    private

    def build_and_fetch(attribute_name)
      @generated_attributes[attribute_name] ||= Attributes.roll(on: attribute_name, generator: self)
      @generated_attributes.fetch(attribute_name)
    end
  end
end
