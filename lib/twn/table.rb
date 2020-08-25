module Twn
  # A class useful for registering tables associated with each attribute.
  class Table
    def initialize(attribute_name:, &block)
      @attribute_name = attribute_name
      @rows_by_roll = {}
      @rows_by_uwp_slug = {}
      if block_given?
        instance_exec(&block) if block.arity == 0
        yield(self) if block.arity == 1
      end
    end

    def shuffle
      rows.shuffle
    end

    def rows
      @rows_by_roll.values
    end

    def fetch_by_roll(roll)
      roll = @rows_by_roll.keys.min if roll < @rows_by_roll.keys.min
      roll = @rows_by_roll.keys.max if roll > @rows_by_roll.keys.max
      @rows_by_roll.fetch(roll)
    end

    def fetch_by_uwp_slug(key)
      @rows_by_uwp_slug.fetch(key)
    end

    def add_row(roll:, to_uwp_slug: nil, constraints: [], **attributes)
      row = Row.new(roll: roll, to_uwp_slug: to_uwp_slug, constraints: constraints, **attributes)
      raise Error if @rows_by_roll.key?(row.roll)
      @rows_by_roll[row.roll] = row
      @rows_by_uwp_slug[row.to_uwp_slug] = row
    end
    alias row add_row

    class Row
      def initialize(roll:, to_uwp_slug: nil, constraints: [], **attributes)
        @roll = roll
        @to_uwp_slug = to_uwp_slug || Utility.to_uwp_slug(roll)
        @constraints = Array(constraints)
        @attributes = attributes
      end
      attr_reader :roll, :to_uwp_slug, :constraints

      def [](key)
        @attributes[key]
      end
    end
  end
end
