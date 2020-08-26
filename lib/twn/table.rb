require 'twn/error'
require 'twn/row'
module Twn
  # A class useful for registering tables associated with each attribute.
  class Table
    # @param attribute_name [Symbol] the name of the table.
    # @yield the configuration block for this table.
    def initialize(attribute_name:, &configuration)
      @attribute_name = attribute_name
      @raw_rows = []
      instance_exec(&configuration)
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
      @from_uwp_slug.call(key)
    end

    protected

    def row(roll:, to_uwp_slug: @to_uwp_slug, constraints: [], **attributes)
      @raw_rows << { roll: roll, to_uwp_slug: to_uwp_slug, constraints: constraints, **attributes }
    end

    def to_uwp_slug(callable = nil, &block)
      raise Error if callable && block_given?
      raise Error if !callable && !block_given?
      @to_uwp_slug = callable || block
    end

    def from_uwp_slug(callable = nil, &block)
      raise Error if callable && block_given?
      raise Error if !callable && !block_given?
      @from_uwp_slug = callable || block
    end

    def default_from_uwp_slug(key)
      rows.find {|r| r.to_uwp_slug == key }
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
      @from_uwp_slug ||= method(:default_from_uwp_slug)
    end
  end
end
