require 'spec_helper'

module Twn
  RSpec.describe AttributeBuilder do
    let(:attribute_name) { :BeverageSize }
    let(:table) do -> {
        row(roll: 1, name: "Small")
        row(roll: 2, name: "Small")
        row(roll: 3, name: "Medium")
        row(roll: 4, name: "Medium")
        row(roll: 5, name: "Large")
        row(roll: 6, name: "Large")
      }
    end

    describe "#roll!" do
      let(:builder) do
        given_table = table # Need the lexical binding
        given_roller = roller # Need the lexical binding
        described_class.new(attribute_name: attribute_name) do
          table(&given_table)
          roller(&given_roller)
        end
      end
      subject { builder.roll! }
      describe 'with a single roll' do
        let(:roller) { -> { roll("1d6") } }
        it { is_expected.to be_a Twn::Attribute }
      end

      describe 'with external class collaborator' do
        let(:roller) { -> { Utility.roll("1d6") } }
        it { is_expected.to be_a Twn::Attribute }
      end
      describe 'with multiple rolls' do
        let(:roller) { -> { [roll("1d6"), roll("1d6")] } }
        it { is_expected.to be_a Twn::CompositeAttribute }
      end
    end
  end
end
