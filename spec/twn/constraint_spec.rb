require 'spec_helper'

module Twn
  RSpec.describe Constraint do
    let(:applies_to) { :Size }
    let(:uwp_range) { ["1", "A"] }
    subject { described_class.new(applies_to: applies_to, uwp_range: uwp_range, state: state) }
    describe "when state has applicable entry" do
      let(:to_uwp) { uwp_range.first }
      let(:state) { { applies_to => double(to_uwp: to_uwp) } }
      it { is_expected.to be_applicable }
      context "and state has object in uwp_range" do
        it { is_expected.to be_acceptable }
      end

      context "and state has object not in uwp_range" do
        let(:to_uwp) { "X" }
        it { is_expected.not_to be_acceptable }
      end
    end

    describe "when state does not have an applicable entry" do
      let(:to_uwp) { uwp_range.first }
      let(:state) { { :Wonk => double(to_uwp: to_uwp) } }
      it { is_expected.not_to be_applicable }
      it { is_expected.to be_acceptable }
    end
  end
end
