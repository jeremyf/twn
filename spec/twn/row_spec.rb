require 'spec_helper'

module Twn
  RSpec.describe Row do
    let(:given_roll) { 1 }
    describe '#to_uwp_slug' do
      it 'works with the given scenarios' do
        callable = ->(row) { "F#{row.roll}#{row.fetch(:hello)}" }
        attributes = { roll: given_roll, hello: :world }
        [
          [nil, Utility.to_uwp_slug(given_roll)],
          [given_roll, given_roll],
          [callable, "F#{given_roll}#{attributes.fetch(:hello)}"]
        ].each do |given_to_uwp_slug, expected_to_uwp_slug|
          row = described_class.new(**attributes.merge(to_uwp_slug: given_to_uwp_slug))
          expect(row.to_uwp_slug).to eq(expected_to_uwp_slug)
        end
      end
    end
  end
end
