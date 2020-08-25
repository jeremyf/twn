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

    def roll_on_table
      roll = RollEvaluator.new.instance_exec(&roller)
      if roll.is_a?(Array)
        rows = roll.map {|r| table.fetch_by_roll(r) }
        CompositeAttribute.new(entries: rows)
      else
        row = table.fetch_by_roll(roll)
        Attribute.new(entry: row)
      end
    end

    protected

    def table(&block)
      return @table if @table
      @table = Table.new(attribute_name: attribute_name, &block)
    end

    # @example
    def roller(callable = nil, &block)
      return @roller if @roller
      raise Error if callable and block_given?
      @roller = callable || block
    end

    class RollEvaluator < BasicObject
      def initialize(generator: Generator.new)
        @generator = generator
      end

      def roll(*args)
        Utility.roll(*args)
      end

      def get!(key)
        generator.get!(key)
      end
    end
  end
end
