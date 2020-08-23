require 'forwardable'
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

    extend Forwardable
    # These are included to conform to the Constraint interaction
    def_delegators :@generated_attributes, :key?, :fetch

    def get!(attribute_name)
      build_and_fetch(attribute_name)
    end

    private

    def build_and_fetch(attribute_name)
      @generated_attributes[attribute_name] ||= Attributes.roll(on: attribute_name, generator: self)
      fetch(attribute_name)
    end
  end
end
