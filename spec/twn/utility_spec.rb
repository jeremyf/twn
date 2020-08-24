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

    describe ".to_uwp_slug" do
      [
        [1,"1"],
        [10,"A"],
        ["A", "A"],
        ["a", "a"],
        ["X", "X"],
        [15, "F"]
      ].each do |input, expected|
        it "converts #{input.inspect} to #{expected.inspect}" do
          expect(described_class.to_uwp_slug(input)).to eq(expected)
        end
      end

      it "calls the given input's #to_uwp_slug if it responds to #to_uwp_slug" do
        input = double(to_uwp_slug: "A")
        expect(described_class.to_uwp_slug(input)).to eq(input.to_uwp_slug)
      end
    end

    describe '.select_random_entry_from_intersection_of' do
      describe 'with only one uwp_slug in all ranges' do
        it "returns that uwp_slug" do
          result = described_class.select_random_entry_from_intersection_of(array_of_ranges: [["A","B"],["A","C"],["A", "C"]])
          expect(result).to eq("A")
        end
      end
      describe 'with more than one uwp_slug in all ranges' do
        it "returns a random" do
          result = described_class.select_random_entry_from_intersection_of(array_of_ranges: [["A","B"],["A","B", "C"],["A", "C"]])
          expect(result).to be_a String
        end
      end
      describe 'with no uwl_slugs in all ranges' do
        it "raises an exception" do
          expect {  described_class.select_random_entry_from_intersection_of(array_of_ranges: [["A","B"],["B", "C"],["A", "C"]]) }.to raise_error(Twn::Error)
        end
      end
    end
  end
end
