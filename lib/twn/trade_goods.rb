module Twn
  module TradeGoods
    def self.table(&table)
      return @table unless @table.nil?
      @table = table
    end
  end
end
