require 'spec_helper'

module Twn
  RSpec.describe Generator do
    let(:generator) { described_class.new }
    describe '#roll' do
      subject { generator.roll(notation, modifier) }
      context "with a known notation (e.g. 2d6)" do
        let(:notation) { "2d6" }
        let(:modifier) { 0 }
        it { is_expected.to be_a Integer }
      end
    end
  end
end
