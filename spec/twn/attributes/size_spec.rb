require 'spec_helper'

module Twn
  module Attributes
    RSpec.describe Size do
      describe ".roll!" do
        let(:generator) { double("Generator", roll: 2) }
        subject { described_class.roll!(generator: generator) }

        it { is_expected.to respond_to(:to_uwp) }
      end
    end
  end
end
