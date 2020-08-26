require 'spec_helper'
require 'twn/attribute_builder'
module Twn
  RSpec.describe AttributeBuilder do
    let(:generator) { double }
    let(:attribute_name) { :BeverageSize }
    let(:expected_uwp_slug_range) { ["S", "M", "L"] }
    let(:table) do -> {
        to_uwp_slug ->(row) { row.fetch(:name)[0] }
        row(roll: 1, name: "Small")
        row(roll: 2, name: "Small")
        row(roll: 3, name: "Medium")
        row(roll: 4, name: "Medium")
        row(roll: 5, name: "Large")
        row(roll: 6, name: "Large")
      }
    end
    let(:roller) { -> { roll("1d6") } }
    let(:builder) do
      given_table = table # Need the lexical binding
      given_roller = roller # Need the lexical binding
      described_class.new(attribute_name: attribute_name) do
        table(&given_table)
        roller(&given_roller)
      end
    end

    describe "#roll!" do
      subject { builder.roll!(generator: generator) }

      describe 'with a single roll' do
        let(:roller) { -> { roll("1d6") } }
        it { is_expected.to be_a Twn::Attribute }
        it "applies the configured to_uwp_slug" do
          expect(expected_uwp_slug_range).to include subject.to_uwp_slug
        end
      end

      describe 'with external class collaborator' do
        let(:roller) { -> { Utility.roll("1d6") } }
        it { is_expected.to be_a Twn::Attribute }
        it "applies the configured to_uwp_slug" do
          expect(expected_uwp_slug_range).to include subject.to_uwp_slug
        end
      end
      describe 'with multiple rolls' do
        let(:roller) { -> { [roll("1d6"), roll("1d6")] } }
        it { is_expected.to be_a Twn::CompositeAttribute }
        it "applies the configured to_uwp_slug" do
          expect(subject.to_uwp_slug).to match(%r{^[SML] [SML]$})
        end
      end
    end
  end
end
