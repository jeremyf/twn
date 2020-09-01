Twn::Attributes.register(:T5Nobility, package: :T5) do
  table do
    row(roll: "B", description: "Knight")
    row(roll: "c", description: "Baronet")
    row(roll: "C", description: "Baron")
    row(roll: "D", description: "Marquis")
    row(roll: "e", description: "Viscount")
    row(roll: "E", description: "Count")
    row(roll: "f", description: "Duke")
    row(roll: "F", description: "Duke")
    row(roll: "G", description: "Archduke")
  end

  # @todo Need to add Capital handling
  roller do
    trade_codes =  get!(:TradeCodes).to_a
    rolls = ["B"]
    rolls << "c" if trade_codes.include?("Pa") || trade_codes.include?("Pr")
    rolls << "C" if trade_codes.include?("Ag") || trade_codes.include?("Ri")
    rolls << "D" if trade_codes.include?("Pi")
    rolls << "e" if trade_codes.include?("Ph")
    rolls << "E" if trade_codes.include?("In") || trade_codes.include?("Hi")
    rolls << "f" if get!(:T5ImportanceExtension).roll >= 4
    rolls
  end
end
