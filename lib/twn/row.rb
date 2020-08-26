require 'forwardable'

module Twn
  class Row
    def initialize(roll:, constraints: [], **attributes)
      @roll = roll
      @to_uwp_slug = attributes.delete(:to_uwp_slug) || Utility.to_uwp_slug(roll)
      @constraints = Array(constraints)
      @attributes = attributes
    end
    attr_reader :roll, :constraints

    def to_uwp_slug
      if @to_uwp_slug.respond_to?(:call)
        @to_uwp_slug.call(self)
      else
        @to_uwp_slug || Utility.to_uwp_slug(roll)
      end
    end

    extend Forwardable
    def_delegators :@attributes, :[], :fetch

    def merge(with:)
      attributes = with.merge(@attributes)
      # Note: I'm not looking to evaluate the UWP slug but instead pass its "builder" method.
      self.class.new(roll: roll, to_uwp_slug: @to_uwp_slug, constraints: constraints, **attributes)
    end
  end
end
