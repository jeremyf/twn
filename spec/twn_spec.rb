RSpec.describe Twn do
  it "has a version number" do
    expect(Twn::VERSION).not_to be nil
  end

  describe ".generate" do
    subject { described_class.generate(sequence: []) }
    it { is_expected.to be_a Twn::Generator }

    context "with default sequence" do
      subject { described_class.generate }
      it { is_expected.to be_a Twn::Generator }
    end
    it "succeeds at 200 scenarios" do
      expect { 200.times { described_class.generate } }.not_to raise_error
    end
  end


  describe ".uwp"
end
