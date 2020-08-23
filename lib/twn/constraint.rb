module Twn
  # A constraint is something that is either met or rejected.
  #
  # There are two major concepts:
  #
  # - Applicability
  # - Acceptability
  class Constraint
    # @param applies_to [Symbol] One of the Twn::Attributes.constants
    # @param uwp_slug_range [Array<String>] An array of UWPs that are, by rules, acceptable
    def initialize(applies_to:, uwp_slug_range:)
      @applies_to = applies_to
      @uwp_slug_range = uwp_slug_range.map { |u| Utility.to_uwp_slug(u) }
    end

    attr_reader :applies_to, :uwp_slug_range

    # Answers two questions:
    #
    # - Applicability
    # - Acceptability
    #
    # @param candidate [#attribute_name]
    # @return [Boolean]
    def acceptable_candidate?(candidate)
      return true unless applies_to == candidate.attribute_name # This is not applicable
      uwp_slug_range.include?(Utility.to_uwp_slug(candidate)) # This is or is not acceptable
    end
  end
end
