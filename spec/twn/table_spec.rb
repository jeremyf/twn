require 'spec_helper'

module Twn
  RSpec.describe Table do
    let(:table) { described_class.new(attribute_name: :Size) }
    describe "#add_row" do
      it "increments the rows" do
        expect { table.add_row(roll: 1, name: "Small") }.to change { table.rows.count }.by(1)
      end

      it "raises an Error if you add the same roll or uwp_slug" do
        expect { table.add_row(roll: 1, name: "Small") }.to change { table.rows.count }.by(1)
        expect { table.add_row(roll: 1, name: "New") }.to raise_error(Error)
      end
    end
  end
end
