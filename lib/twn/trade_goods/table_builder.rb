require "twn/error"
require "twn/trade_goods/row_builder"
module Twn
  module TradeCodes
    class TableBuilder < BasicObject
      def initialize(&config)
        @table = {}
        instance_exec(&config)
      end

      # @param integer [Integer]
      # @param name [String]
      # @param roll_config
      def row(integer, name:, &roll_config)
        raise Error if @table.key?(integer)
        @table[integer] = RowBuilder.new(roll: integer, name: name, &roll_config)
      end
    end
  end
end
