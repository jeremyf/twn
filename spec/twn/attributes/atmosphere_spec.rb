require 'spec_helper'

module Twn
  module Attributes
    RSpec.describe Atmosphere do

      describe '.roll!' do
        let(:generator) { double("Generator") }
        subject { described_class.roll!(generator: generator) }
        before do
          expect(generator).to receive(:roll).with("2d6", -7, modified_by: :Size).and_return(2)
        end
        it { is_expected.to be_a described_class }
      end
    end
  end
end
