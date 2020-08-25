require 'spec_helper'

module Twn
  RSpec.describe AttributeBuilder do
    let(:attribute_name) { :BeverageSize }

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

    describe "#roll_on_table" do
      subject { builder.roll_on_table }
      it { is_expected.to respond_to :to_uwp_slug }
    end
  end
end
