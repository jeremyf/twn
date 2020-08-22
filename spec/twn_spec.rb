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
  end
end
