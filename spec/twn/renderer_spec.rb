require 'spec_helper'

module Twn
  RSpec.describe Renderer do
    let(:buffer) { double }
    subject { described_class.new(buffer: buffer) }
    describe "#to_uwp" do
      it "puts text to the buffer" do
        expect(buffer).to receive(:puts).with(String)
        subject.to_uwp
      end
    end
  end
end
