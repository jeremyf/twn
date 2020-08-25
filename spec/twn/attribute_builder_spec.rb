require 'spec_helper'

module Twn
  RSpec.describe AttributeBuilder do
    let(:attribute_name) { :BeverageSize }
    describe "#roll_on_table" do
      subject { builder.roll_on_table }
      describe 'with a single roll' do
        let(:builder) do
          described_class.new(attribute_name: attribute_name) do
            table do
              row(roll: 1, name: "Small")
              row(roll: 2, name: "Medium")
              row(roll: 3, name: "Large")
            end
            roller { rand(3) + 1 }
          end
        end
        it { is_expected.to be_a Twn::Attribute }
      end
      describe 'with multiple rolls' do
        let(:builder) do
          described_class.new(attribute_name: attribute_name) do
            table do
              row(roll: 1, name: "Small")
              row(roll: 2, name: "Medium")
              row(roll: 3, name: "Large")
            end
            roller { [1,2] }
          end
        end
        it { is_expected.to be_a Twn::CompositeAttribute }
      end
    end
  end
end
