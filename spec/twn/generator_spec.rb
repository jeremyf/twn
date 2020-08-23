require 'spec_helper'

module Twn
  RSpec.describe Generator do
    let(:generator) { described_class.new }

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
