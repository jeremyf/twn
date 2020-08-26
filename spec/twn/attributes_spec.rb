require 'spec_helper'
require 'twn/attributes'
module Twn
  RSpec.describe Attributes do
    describe '.roll' do
      let(:on) { :Size }
      let(:generator) { double("Generator", roll: 1) }
      subject { described_class.roll(on: on, generator: generator) }
      it { is_expected.to be_a Twn::Attribute }
    end
    describe '.roller_for' do
      subject { described_class.roller_for(class_name) }
      context 'with existing Twn::Attribute' do
        let(:class_name) { :Size }

        it { is_expected.to respond_to(:roll!) }
      end
      context 'with a non-existing Twn::Attribute' do
        let(:class_name) { :ChickenNugget }
        it "is expected to raise a NameError" do
          expect { subject }.to raise_error(KeyError)
        end
      end
    end
  end
end
