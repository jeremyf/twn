require 'twn/error'
require 'twn/row'
module Twn
  # A class to build a table for lookup
  class Table
    # @param attribute_name [Symbol] the name of the table.
    # @yield the configuration block for this table.
    #
    #
    # @example
    #   Twn::Table.new(attribute_name: :Faction) do
    #     from_uwp_slug do |uwp_slug|
    #       strength = uwp_slug[1..2]
    #       government = uwp_slug[3]
    #       row = rows.find { |r| r.fetch(:strength).start_with?(strength) }
    #       government = find(:Government, uwp_slug: government)
    #       row.merge(government: government)
    #     end
    #
    #     to_uwp_slug { |row| "F#{row.fetch(:strength)[0..1]}#{row.fetch(:government).to_uwp_slug}" }
    #
    #     row(roll: 2, strength: "Obscure group - few have heard of them, no popular support")
    #     row(roll: 3, strength: "Obscure group - few have heard of them, no popular support")
    #     row(roll: 4, strength: "Finger group - few supporters")
    #     row(roll: 5, strength: "Finger group - few supporters")
    #     row(roll: 6, strength: "Minor group - some supporters")
    #     row(roll: 7, strength: "Minor group - some supporters")
    #     row(roll: 8, strength: "Notable group - significant support, well known")
    #     row(roll: 9, strength: "Notable group - significant support, well known")
    #     row(roll: 10, strength: "Signficant - nearly as powerful as the government")
    #     row(roll: 11, strength: "Signficant - nearly as powerful as the government")
    #     row(roll: 12, strength: "Overwhelming popular support - more powerful than the government")
    #   end
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
      @from_uwp_slug.call(key) || raise(Error.new("No entry found for #{key.inspect}"))
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
