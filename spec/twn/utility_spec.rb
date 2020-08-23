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
  end
end
