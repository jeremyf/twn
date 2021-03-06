require 'spec_helper'
require 'twn'
RSpec.describe Twn do
  it "has a version number" do
    expect(Twn::VERSION).not_to be nil
  end

  describe ".available_package_names" do
    subject { described_class.available_package_names }
    it { is_expected.to include(:Core) }
    it { is_expected.to include(:SWN) }
    it { is_expected.to include(:Security) }
    it { is_expected.to include(:Factions) }
  end


  describe ".generate" do
    subject { described_class.generate(packages: []) }
    it { is_expected.to be_a Twn::Generator }

    TIMES = 500
    it "succeeds at #{TIMES} scenarios" do
      failures = 0
      successes = 0
      TIMES.times do
        begin
          described_class.generate
          successes += 1
        rescue Twn::Error
          failures += 1
        end
      end
      expect(failures).to eq(0)
    end
  end
end
