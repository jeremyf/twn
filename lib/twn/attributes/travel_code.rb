Twn::Attributes.register(:TravelCode) do
  no = ""
  amber = "A"
  red = "R"
  table do
    row(roll: no, description: "No travel code")
    row(roll: amber, description: "Amber travel code")
    row(roll: red, description: "Red travel code")
  end
  roller do
    if roll("2d6") == 12
      red
    elsif get!(:Atmosphere).roll > 10
      amber
    elsif [0,7,10].include?(get!(:Government).roll)
      amber
    else
      law_roll = get!(:LawLevel).roll
      if law_roll == 0 || law_roll >= 9
        amber
      else
        no
      end
    end
  end
end
