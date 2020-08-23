require 'spec_helper'

module Twn
  RSpec.describe Constraint do
    let(:applies_to) { :Size }
    let(:uwp_slug_range) { ["1", "A"] }
    subject { described_class.new(applies_to: applies_to, uwp_slug_range: uwp_slug_range, state: state) }
    describe "when state has applicable entry" do
      let(:to_uwp_slug) { uwp_slug_range.first }
      let(:state) { { applies_to => to_uwp_slug } }
      it { is_expected.to be_applicable }
      context "and state has object in uwp_slug_range" do
        it { is_expected.to be_acceptable }
      end

      context "and state has object not in uwp_slug_range" do
        let(:to_uwp_slug) { "X" }
        it { is_expected.not_to be_acceptable }
      end
    end

    describe "when state does not have an applicable entry" do
      let(:to_uwp_slug) { uwp_slug_range.first }
      let(:state) { { :Wonk => to_uwp_slug } }
      it { is_expected.not_to be_applicable }
      it { is_expected.to be_acceptable }
    end
  end
end
