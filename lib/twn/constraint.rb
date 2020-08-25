module Twn
  # A constraint is something that is either met or rejected.
  #
  # There are two major concepts:
  #
  # - Applicability
  # - Acceptability
  class Constraint
    # @param applies_to [Symbol, #to_sym] One of the Twn::Attributes.constants
    # @param uwp_slug_range [Array<String>] An array of UWPs that are, by rules, acceptable
    # @param from This answers the question "Where did this constraint come from?"
    def initialize(applies_to:, uwp_slug_range:, from: :unkown)
      @applies_to = applies_to.to_sym
      @uwp_slug_range = uwp_slug_range.map { |u| Utility.to_uwp_slug(u) }
      @from = from
    end

    attr_reader :applies_to, :uwp_slug_range, :from

    # Is this an applicable candidate for the constraint?
    #
    # @param candidate [#attribute_name]
    # @return [Boolean]
    def applicable?(candidate:)
      candidate.attribute_name == applies_to
    end

    # Answers two questions:
    #
    # - Applicability
    # - Acceptability
    #
    # @param candidate [#attribute_name]
    # @return [Boolean]
    def acceptable?(candidate:)
      return true unless applicable?(candidate: candidate)
      uwp_slug_range.include?(Utility.to_uwp_slug(candidate)) # This is or is not acceptable
    end
  end
end
