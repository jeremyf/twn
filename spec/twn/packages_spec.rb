require "spec_helper"
require "twn/packages"

module Twn
  module Packages
    RSpec.describe Builder do
      let(:builder) { described_class.new(name: :York, &configuration) }
      let(:configuration) do
        the_to_uwp = given_to_uwp # For lexical binding
        -> { to_uwp(&the_to_uwp) }
      end
      let(:given_to_uwp) { -> { sprintf("%4d", 2) } }

      describe "#initialize" do
        subject { builder }
        it "captures the configuration block" do
          expect(subject).to be_a(described_class)
        end
      end

      describe "#render" do
        subject { builder.render(generator: generator, format: :to_uwp) }
        let(:generator) { double }
        context "with format: :to_uwp" do
          it { is_expected.to be_a(String) }
        end
      end
    end
  end
end
