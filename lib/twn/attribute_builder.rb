require 'twn/utility'
require 'twn/table'
require 'twn/attribute'
require 'twn/generator'

module Twn
  # Having hand-crafted about 15 attributes, I've come upon a common
  # builder pattern that eschews inheritence.  By leveraging a builder
  # pattern, I should more easily be able to add attributes into the
  # ecosystem.
  #
  # @todo Fully implement the example
  # @example
  #   Twn::Attributes.register(:Size) do
  #     table do
  #       row(roll: 1, name: "Small")
  #       row(roll: 2, name: "Medium") do
  #         constraint(:Atmosphere).to_uwp_slug_range(1,2)
  #       end
  #       row(roll: 3, name: "Large")
  #     end
  #
  #     roller do
  #       roll("1d3") + roll_for(:Value) + uwp_slug_for(:Cost)
  #     end
  #   end
  class AttributeBuilder
    def initialize(attribute_name:, &block)
      @attribute_name = attribute_name
      instance_exec(&block)
    end
    attr_reader :attribute_name

    def roll!(generator: Generator.new)
      roll = RollEvaluator.new(generator: generator).instance_exec(&roller)
      if roll.is_a?(Array)
        rows = roll.map {|r| fetch_by_roll(r) }
        CompositeAttribute.new(attribute_name: attribute_name, entries: rows)
      else
        row = fetch_by_roll(roll)
        Attribute.new(attribute_name: attribute_name, entry: row)
      end
    end
    alias roll_on_table roll!

    extend Forwardable
    def_delegators :@table, :fetch_by_uwp_slug

    protected

    def fetch_by_roll(r)
      return table.fetch_by_roll(r) unless r.is_a?(Hash)
      roll = r.fetch(:roll)
      r.delete(:roll)
      row = table.fetch_by_roll(roll)
      row.merge(with: r, to_uwp_slug: to_uwp_slug)
    end

    def table(&block)
      return @table if @table
      @table = Table.new(attribute_name: attribute_name, &block)
    end

    def to_uwp_slug(callable = nil, &block)
      return @to_uwp_slug if @to_uwp_slug
      raise Error if callable and block_given?
      @to_uwp_slug = callable || block
    end

    # @example
    def roller(callable = nil, &block)
      return @roller if @roller
      raise Error if callable and block_given?
      @roller = callable || block
    end

    # A "clean room" object that exposes only the most basic of
    # methods
    class RollEvaluator < BasicObject
      def initialize(generator:)
        @generator = generator
      end

      def roll(*args)
        Utility.roll(*args)
      end

      def to_uwp_slug(*args)
        Utility.to_uwp_slug(*args)
      end

      def get!(*args)
        @generator.get!(*args)
      end

      def roll_for(*args)
        @generator.roll_for(*args)
      end
    end
    private_constant :RollEvaluator
  end
end
