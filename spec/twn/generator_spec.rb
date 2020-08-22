require 'spec_helper'

module Twn
  RSpec.describe Generator do
    let(:generator) { described_class.new }
    describe '#roll' do
      subject { generator.roll(dice, modifier) }
      context "with a known notation (e.g. 2d6)" do
        let(:dice) { "2d6" }
        let(:modifier) { 0 }
        it { is_expected.to be_a Integer }
      end
    end

    describe '#generate' do
      Attributes.each do |attribute|
        describe "for #{attribute}" do
          subject { generator.generate(attribute) }
          it { is_expected.to be_a Attributes.const_get(attribute) }
        end
      end
    end
  end
end
