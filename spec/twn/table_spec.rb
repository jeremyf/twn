require 'spec_helper'

module Twn
  RSpec.describe Table do
    let(:table) { described_class.new(attribute_name: :Size, &configuration) }
    describe "#initialize" do
      describe 'with row' do
        let(:configuration) do
          -> do
            to_uwp_slug { |row| row.fetch(:name)[0] }
            row(roll: 1, name: "Small")
          end
        end
        it "creates a row" do
          expect(table.rows.count).to eq(1)
        end

        it "configures the to_uwp_slug" do
          roll = table.fetch_by_roll(1)
          expect(roll.to_uwp_slug).to eq("S")
        end
      end
    end
  end
end
