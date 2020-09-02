require "forwardable"
require "twn/error"
require "twn/trade_goods/row_builder"
module Twn
  module TradeGoods
    class TableBuilder
      def initialize(&config)
        @registry = {}
        instance_exec(&config)
      end

      # @param integer [Integer]
      # @param name [String]
      # @param roll_config
      def row(integer, name:, &roll_config)
        raise Error if @registry.key?(integer)
        @registry[integer] = RowBuilder.new(roll: integer, name: name, &roll_config)
      end

      extend Forwardable
      def_delegators :@registry, :fetch
    end
  end
end
