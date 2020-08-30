# Extrapolated from T5.10, Book 3, p24, table 2B
Twn::Attributes.register(:T5ImportanceExtension, package: :T5) do
  table do
    row(roll: -3, importance: "Very unimportant", weekly_traffic: 0, daily_traffic: 0)
    row(roll: -2, importance: "Very unimportant", weekly_traffic: 0, daily_traffic: 0)
    row(roll: -1, importance: "Unimportant", weekly_traffic: 1, daily_traffic: 1)
    row(roll: 0, importance: "Unimportant", weekly_traffic: 2, daily_traffic: 1)
    row(roll: 1, importance: "Ordinary", weekly_traffic: 10, daily_traffic: (1..2))
    row(roll: 2, importance: "Ordinary", weekly_traffic: 20, daily_traffic: (2..4))
    row(roll: 3, importance: "Ordinary", weekly_traffic: 30, daily_traffic: (3..6))
    row(roll: 4, importance: "Important", weekly_traffic: 100, daily_traffic: (15..20))
    row(roll: 5, importance: "Very important", weekly_traffic: 1000, daily_traffic: 100)
  end

  roller do
    importance = 0
    case get!(:Starport)
    when "A", "B" then importance += 1
    when "D", "E", "X" then importance += -1
    end

    case get!(:TechLevel)
    when (15..30) then importance += 2
    when (10..14) then importance += 1
    when (0..8) then importance += -1
    end

    # TODO Trade Codes
    important_trade_codes = ["Per", "Ag", "Hi", "In", "Ri"]
    trade_codes = get!(:TradeCodes).uwp_slug.split(" ")
    importance += 1 unless (important_trade_codes & trade_codes).empty?
    importance -= 1 if get!(:Population).roll <= 6
    importance += 1 if get!(:NavalBase) == "N" && get!(:ScoutBase) == "S"
    importance += 1 if get!(:TravellersAidSociety) == "T"

    importance
  end
end
