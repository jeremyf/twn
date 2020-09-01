require 'twn/utility'
module Twn
  # A class to assist in capturing
  module TradeGoods
    class RowBuilder
      def initialize(roll:, name:, &configuration)
        @roll = roll
        @name = name
        instance_exec(&configuration)
      end
      attr_reader :roll, :name

      def description(input = nil)
        return @description unless @description.nil?
        @description = input.to_s
      end

      def base_price(input = nil)
        return @base_price unless @base_price.nil?
        @base_prince = input.to_i
      end

      def available(input = nil)
        return @available unless @availabe.nil?
        @available = input
      end

      def tons(dice = nil, x: 1)
        return @tons.call unless @tons.nil?
        @tons = -> { Utility.roll(dice) * x }
      end

      def purchase(**trade_codes)
        return @purchase unless @purchase.nil?
        @purchase = trade_codes
      end

      def sale(**trade_codes)
        return @sale unless @sale.nil?
        @sale = trade_codes
      end
    end
  end
end
