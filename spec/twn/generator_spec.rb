require 'spec_helper'

module Twn
  RSpec.describe Generator do
    let(:generator) { described_class.new }

    describe '#set!' do
      let(:uwp_slug) { Utility.to_uwp_slug(10) }
      it "forces the entry" do
        generator.set!(:Size, uwp_slug: uwp_slug)
        expect(generator.get!(:Size).to_uwp_slug).to eq(uwp_slug)
      end
    end
    describe '#get!' do
      Attributes.each do |attribute|
        describe "for #{attribute}" do
          subject { generator.get!(attribute) }
          it { is_expected.to be_a Attributes.const_get(attribute) }
        end
      end

      describe 'with a constraint' do
        let(:uwp_slug_range) { ["1"].map { |i| Utility.to_uwp_slug(i) } }
        let(:applies_to) { :Size }
        before do
          generator.add_constraint!(applies_to: applies_to, uwp_slug_range: uwp_slug_range)
        end

        it "only allows generation of the applicable attribute within the given uwp_slug_range" do
          expect(uwp_slug_range).to include(generator.get!(applies_to).to_uwp_slug)
        end
      end
    end
  end
end
