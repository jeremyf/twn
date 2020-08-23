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
      end
    end
  end
end
