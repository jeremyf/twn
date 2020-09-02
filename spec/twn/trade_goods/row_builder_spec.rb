require 'spec_helper'
require 'twn/trade_goods/row_builder'

module Twn
  module TradeGoods
    RSpec.describe RowBuilder do
      subject do
        described_class.new(roll: 11, name: "Common Electronics") do
          availability(:all)
          tons("2d6", x: 10)
          base_price(1000)
          purchase(In: 2, HT: 3, Ri: 1)
          sale(NI: 2, LT: 1, Po: 1)
        end
      end
      its(:tons) { is_expected.to be_a(Integer) }
      its(:sale) { is_expected.to be_a(Hash) }
      its(:purchase) { is_expected.to be_a(Hash) }
      its(:base_price) { is_expected.to be_a(Integer) }
    end
  end
end
