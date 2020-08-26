require 'twn/error'
require 'twn/row'
module Twn
  # A class useful for registering tables associated with each attribute.
  class Table
    def initialize(attribute_name:, &block)
      @attribute_name = attribute_name
      @raw_rows = []
      instance_exec(&block) if block.arity == 0
      yield(self) if block.arity == 1
      finish!
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
      rows.find {|r| r.to_uwp_slug == key }
    end

    protected

    def row(roll:, to_uwp_slug: @to_uwp_slug, constraints: [], **attributes)
      @raw_rows << { roll: roll, to_uwp_slug: to_uwp_slug, constraints: constraints, **attributes }
    end

    def to_uwp_slug(callable = nil, &block)
      return @to_uwp_slug if @to_uwp_slug
      # raise Error if callable and block_given?
      @to_uwp_slug = callable || block
    end

    private

    def finish!
      @rows_by_roll = {}
      @raw_rows.each do |raw_row|
        raw_row[:to_uwp_slug] ||= @to_uwp_slug
        row = Row.new(**raw_row)
        raise Error if @rows_by_roll.key?(row.roll)
        @rows_by_roll[row.roll] = row
      end
    end
  end
end
