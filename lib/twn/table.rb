module Twn
  class Table
    def initialize(attribute_name:)
      @attribute_name = attribute_name
      @rows_by_roll = {}
      @rows_by_uwp_slug = {}
      yield(self) if block_given?
    end

    def rows
      @rows_by_roll.values
    end

    def fetch_by_roll(key)
      @rows_by_roll.fetch(key)
    end

    def fetch_by_uwp_slug(key)
      @rows_by_uwp_slug.fetch(key)
    end

    def add_row(roll:, to_uwp_slug: nil, **attributes)
      row = Row.new(roll: roll, to_uwp_slug: to_uwp_slug, **attributes)
      raise Error if @rows_by_roll.key?(row.roll)
      raise Error if @rows_by_uwp_slug.key?(row.to_uwp_slug)
      @rows_by_roll[row.roll] = row
      @rows_by_uwp_slug[row.to_uwp_slug] = row
    end

    class Row
      def initialize(roll:, to_uwp_slug: nil, **attributes)
        @roll = roll
        @to_uwp_slug = to_uwp_slug || Utility.to_uwp_slug(roll)
        @attributes = attributes
      end
      attr_reader :roll, :to_uwp_slug
    end
  end
end
