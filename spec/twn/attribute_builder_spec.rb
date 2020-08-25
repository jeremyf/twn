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
              row(roll: 2, name: "Small")
              row(roll: 3, name: "Medium")
              row(roll: 4, name: "Medium")
              row(roll: 5, name: "Large")
              row(roll: 6, name: "Large")
            end
            roller do
              roll("1d6")
            end
          end
        end
        it { is_expected.to be_a Twn::Attribute }
      end

      describe 'with external class collaborator' do
        let(:builder) do
          described_class.new(attribute_name: attribute_name) do
            table do
              row(roll: 1, name: "Small")
              row(roll: 2, name: "Small")
              row(roll: 3, name: "Medium")
              row(roll: 4, name: "Medium")
              row(roll: 5, name: "Large")
              row(roll: 6, name: "Large")
            end
            roller do
              Utility.roll("1d6")
            end
          end
        end
        it { is_expected.to be_a Twn::Attribute }
      end
      describe 'with multiple rolls' do
        let(:builder) do
          described_class.new(attribute_name: attribute_name) do
            table do
              row(roll: 1, name: "Small")
              row(roll: 2, name: "Small")
              row(roll: 3, name: "Medium")
              row(roll: 4, name: "Medium")
              row(roll: 5, name: "Large")
              row(roll: 6, name: "Large")
            end
            roller { [roll("1d6"), roll("1d6")] }
          end
        end
        it { is_expected.to be_a Twn::CompositeAttribute }
      end
    end
  end
end
