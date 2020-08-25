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
    attr_reader :constraints

    # @see Twn::Constraint
    def add_constraint!(applies_to:, uwp_slug_range:)
      @constraints << Constraint.new(applies_to: applies_to, uwp_slug_range: uwp_slug_range)
    end

    extend Forwardable
    # These are included to conform to the Constraint interaction
    def_delegators :@generated_attributes, :key?, :fetch

    # The TIME_TO_LIVE constaint defines how many attempts are allowed
    # before we force an answer.
    TIME_TO_LIVE = 30
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
    def get!(attribute_name, ttl: TIME_TO_LIVE, force: true)

      return fetch(attribute_name) if key?(attribute_name)
      attribute = nil
      while ttl > 0 && attribute.nil?
        candidate = Attributes.roll(on: attribute_name, generator: self)
        attribute = candidate if acceptable?(candidate: candidate)
        ttl -= 1
      end
      attribute ||= force_attribute(attribute_name: attribute_name) if force
      set_attribute_and_apply_constraint!(key: attribute_name, attribute: attribute)
    end

    # Sets the given named attribute to the given uwp_slug.
    #
    # @param attribute_name [Symbol]
    # @param uwp_slug [String,Integer]
    #
    # @note This is destructive and skips all of the constraints!
    def set!(attribute_name, uwp_slug:)
      attribute = force_attribute(attribute_name: attribute_name, uwp_slug: uwp_slug)
      set_attribute_and_apply_constraint!(key: attribute_name, attribute: attribute)
    end

    private

    def set_attribute_and_apply_constraint!(key:, attribute:)
      @generated_attributes[key] = attribute
      attribute.constraints.each do |constraint|
        add_constraint!(**constraint)
      end
      attribute
    end

    def acceptable?(candidate:)
      @constraints.all? do |constraint|
        constraint.acceptable?(candidate: candidate)
      end
    end

    def force_attribute(attribute_name:, uwp_slug: nil)
      uwp_slug = acceptable_uwp_slug_range_for(attribute_name: attribute_name) if uwp_slug.nil?
      Attributes.fetch(from: attribute_name, uwp_slug: uwp_slug)
    end

    def acceptable_uwp_slug_range_for(attribute_name:, pick_on_fail: true)
      array_of_ranges = []
      @constraints.each do |constraint|
        next unless constraint.applies_to == attribute_name
        array_of_ranges << constraint.uwp_slug_range
      end
      Utility.select_random_entry_from_intersection_of(array_of_ranges: array_of_ranges, pick_on_fail: pick_on_fail)
    end
  end
end
