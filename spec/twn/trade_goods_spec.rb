require "spec_helper"
require "twn/trade_goods"

module Twn
  RSpec.describe TradeGoods do
    let(:table) do
      TradeGoods::TableBuilder.new do
        (11..16).each do |i|
          row(i, name: "Good #{i}") do
            availability(:all) ; tons("2d6", x: 10) ; base_price(10_000 * i); purchase; sale
          end
        end
      end
    end
    let(:trade_goods) { described_class.new(table: table) }
    describe "#roll" do
      subject { trade_goods.roll }
      it { is_expected.to be_a(Array) }
    end
  end
end
