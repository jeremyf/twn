require 'spec_helper'

module Twn
  RSpec.describe Utility do
    describe ".roll" do
      context 'with a known expression' do
        let(:expression_map) { { "1d4" => -> { rand(4) + 1 } } }
        subject { described_class.roll("1d4", expression_map: expression_map) }
        it { is_expected.to be_a Integer }
      end
    end

    describe ".to_uwp" do
      [
        [1,"1"],
        [10,"A"],
        ["A", "A"],
        ["a", "A"],
        ["X", "X"],
        [15, "F"]
      ].each do |input, expected|
        it "converts #{input.inspect} to #{expected.inspect}" do
          expect(described_class.to_uwp(input)).to eq(expected)
        end
      end

      it "calls the given input's #to_uwp if it responds to #to_uwp" do
        input = double(to_uwp: "A")
        expect(described_class.to_uwp(input)).to eq(input.to_uwp)
      end
    end
  end
end
