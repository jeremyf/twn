module Twn
  class Row
    def initialize(roll:, to_uwp_slug: nil, constraints: [], **attributes)
      @roll = roll
      @to_uwp_slug = to_uwp_slug || Utility.to_uwp_slug(roll)
      @constraints = Array(constraints)
      @attributes = attributes
    end
    attr_reader :roll, :constraints

    def to_uwp_slug
      if @to_uwp_slug.respond_to?(:call)
        @to_uwp_slug.call(self)
      else
        @to_uwp_slug
      end
    end

    extend Forwardable
    def_delegators :@attributes, :[], :fetch

    def merge(with:, to_uwp_slug: @to_uwp_slug)
      attributes = with.merge(@attributes)
      self.class.new(roll: roll, to_uwp_slug: to_uwp_slug, constraints: constraints, **attributes)
    end
  end
end
