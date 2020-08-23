module Twn
  # A constraint is something that is either met or rejected.
  #
  # There are two major concepts:
  #
  # - Applicability
  # - Acceptability
  class Constraint
    # @param applies_to [Symbol] One of the Twn::Attributes.constants
    # @param uwp_range [Array<String>] An array of UWPs that are, by rules, acceptable
    # @param state [Hash<Symbol,Twn::Attribute>]
    def initialize(applies_to:, uwp_range:, state:)
      @applies_to = applies_to
      @uwp_range = uwp_range.map { |u| u.to_s.upcase }
      @state = state
    end

    attr_reader :applies_to, :uwp_range, :state

    # True if this Constraint applies to the given state
    # @return [Boolean]
    def applicable?
      state.key?(applies_to)
    end

    # True if the state is acceptable for the given Constraint
    # @return [Boolean]
    def acceptable?
      return true unless applicable?
      uwp_range.include?(state.fetch(applies_to).to_uwp)
    end
  end
end
