require 'spec_helper'

module Twn
  RSpec.describe Constraint do
    let(:applies_to) { :Size }
    let(:uwp_slug_range) { ["1", "A"] }
    let(:constraint) { described_class.new(applies_to: applies_to, uwp_slug_range: uwp_slug_range) }
    describe "#acceptable_candidate?" do
      let(:to_uwp_slug) { uwp_slug_range.first }
      let(:candidate) { double(Twn::Attribute, attribute_name: attribute_name, to_uwp_slug: to_uwp_slug) }
      subject { constraint.acceptable_candidate?(candidate) }

      describe "with candidate that is applicable" do
        let(:attribute_name) { applies_to }
        context "and is in the given range" do
          let(:to_uwp_slug) { uwp_slug_range.first }
          it { is_expected.to be_truthy }
        end

        context "and is NOT in the given range" do
          let(:to_uwp_slug) { "B" }
          it { is_expected.to be_falsey }
        end
      end

      describe "with candidate that is not applicable" do
        let(:attribute_name) { :SomethingElse }
        it { is_expected.to be_truthy }
      end
    end
  end
end
