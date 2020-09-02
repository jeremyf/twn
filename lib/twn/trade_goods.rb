require 'twn/trade_goods/table_builder'
require 'twn/utility'
module Twn
  module TradeGoods
    def self.table(&table)
      return @table unless @table.nil?
      @table = TableBuilder.new(&table)
    end

    def self.new(table: self.class.table)
      Roller.new(table: table)
    end

    class Roller
      def initialize(table:)
        @table = table
      end

      def roll
        common_goods
      end

      private

      def common_goods
        (11..16).map do |i|
          Result.new(row: @table.fetch(i))
        end
      end
    end

    class Result
      def initialize(row:)
        @row = row
      end
      attr_reader :row
    end
  end
end
require 'twn/trade_goods/table'
