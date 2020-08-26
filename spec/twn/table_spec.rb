require 'spec_helper'
require 'twn/table'
module Twn
  RSpec.describe Table do
    let(:table) { described_class.new(attribute_name: :Size, &configuration) }
    describe "#initialize" do
      describe 'with row' do
        let(:configuration) do
          -> do
            from_uwp_slug do |uwp_slug|
              rows.find { |r| r.fetch(:name).start_with?(uwp_slug) }
            end
            to_uwp_slug { |row| row.fetch(:name)[0] }
            row(roll: 1, name: "Small")
            row(roll: 2, name: "Medium")
          end
        end
        it "creates rows" do
          expect(table.rows.count).to eq(2)
        end

        it "configures the to_uwp_slug" do
          roll = table.fetch_by_roll(1)
          expect(roll.to_uwp_slug).to eq("S")
        end

        it "configures the fetch_by_uwp_slug" do
          roll = table.fetch_by_uwp_slug("S")
          expect(roll.to_uwp_slug).to eq("S")
        end
      end
    end
  end
end
