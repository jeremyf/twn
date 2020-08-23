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
      @constraints << Constraint.new(applies_to: applies_to, uwp_slug_range: uwp_slug_range)
    end

    extend Forwardable
    # These are included to conform to the Constraint interaction
    def_delegators :@generated_attributes, :key?, :fetch

    TIME_TO_LIVE = 70
    # Retrieve the existing named attribute if one exists.  Otherwise,
    # roll to generate that attribute, only accepting attributes that
    # meet the constraints.
    #
    # @param attribute_name [Symbol]
    #
    # @param ttl [Integer] The maximum number of attempts to determine
    #       if the candidate is acceptable.
    #
    # @param force [Boolean] If we can't roll an acceptable candidate,
    #       force the creation of one.
    #
    # @todo Apply force within the acceptable range.
    #
    # @note Once we generate an attribute, we never again check the
    #       constraints.  In other words, if you get a :Size and then
    #       later add a constraint for :Size, we'll never check to see
    #       if this is a valid size.
    def get!(attribute_name, ttl: TIME_TO_LIVE, force: false)
      return fetch(attribute_name) if key?(attribute_name)
      attribute = nil
      while ttl > 0 && attribute.nil?
        candidate = Attributes.roll(on: attribute_name, generator: self)
        attribute = candidate if acceptable?(candidate: candidate)
        ttl -= 1
      end
      @generated_attributes[attribute_name] = attribute
      fetch(attribute_name)
    end

    private

    def acceptable?(candidate:)
      @constraints.all? do |constraint|
        constraint.acceptable?(candidate: candidate)
      end
    end

    def acceptable_uwp_slug_range_for(candidate:)
      @constraints.each do

      end
    end
  end
end
