RSpec.describe Twn do
  it "has a version number" do
    expect(Twn::VERSION).not_to be nil
  end

  describe ".generate" do
    let(:buffer) { double(puts: nil) }
    subject { described_class.generate(sequence: [], buffer: buffer) }
    it { is_expected.to be_a Twn::Generator }

    context "with default sequence" do
      subject { described_class.generate(buffer: buffer) }
      it { is_expected.to be_a Twn::Generator }
    end
    it "succeeds at 200 scenarios" do
      failures = 0
      successes = 0
      200.times do
        begin
          described_class.generate(buffer: buffer)
          successes += 1
        rescue Twn::Error
          failures += 1
        end
      end
      expect(failures).to eq(0)
    end
  end


  describe ".uwp"
end
