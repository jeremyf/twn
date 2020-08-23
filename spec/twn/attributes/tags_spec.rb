require 'spec_helper'

module Twn
  module Attributes
    RSpec.describe Tags do
      describe ".roll!" do
        let(:generator) { Twn::Generator.new }
        let(:pick) { 1 }
        subject { described_class.roll!(generator: generator, pick: pick, tags: tags) }
        describe "with a constraint" do
          let(:tags) { [{ name: "Fancy Pants", constraints: [{ applies_to: "Size", uwp_slug_range: [1,2,3] }] }] }
          it "adds that constraint to the generator" do
            expect { subject }.to change { generator.constraints.count }.by(1)
          end
        end
        describe "without a constraint" do
          let(:tags) { [{ name: "Fancy Pants" }] }
          it "will NOT add a constraint to the generator" do
            expect { subject }.not_to change { generator.constraints.count }
          end
        end
      end

      describe ".swn_tags" do
        it "has valid data for assigning constraints" do
          expect {
            described_class.swn_tags.each do |swn_tag|
              described_class.roll!(generator: Generator.new, pick: 1, tags: [swn_tag])
            end
          }.not_to raise_error
        end
      end
    end
  end
end
