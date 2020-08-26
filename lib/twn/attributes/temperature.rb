Twn::Attributes.register(:Temperature) do
  table do
    row(roll: "F", type: "Frozen")
    row(roll: "C", type: "Cold")
    row(roll: "T", type: "Temperate")
    row(roll: "H", type: "Hot")
    row(roll: "R", type: "Roasting")
    row(roll: "V", type: "Volatile: Frozen at night, Roasting during day")
  end

  roller do
    atmosphere_uwp_modifier = {
      "2" => -2, "3" => -2,
      "4" => -1, "5" => -1, "E" => -1,
      "8" => 1, "9" => 1,
      "A" => 2, "D" => 2, "F" => 2,
      "B" => 6, "C" => 6
    }
    case get!(:Size).to_uwp_slug
    when "0", "1" then "V"
    else
      case roll("2d6") + atmosphere_uwp_modifier.fetch(get!(:Atmosphere).to_uwp_slug, 0)
      when (-20..2) then "F"
      when (3..4) then "C"
      when (5..9) then "T"
      when (10..11) then "H"
      when (12..30) then "R"
      end
    end
  end
end
