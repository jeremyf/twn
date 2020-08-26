Twn::Attributes.register(:SwnTemperature) do
  table do
    row(roll: "Fr", type: "Frozen", constraints: [ { applies_to: :Temperature, uwp_slug_range: ["F"] }])
    row(roll: "Co", type: "Cold", constraints: [ { applies_to: :Temperature, uwp_slug_range: ["C"] }])
    row(roll: "TC", type: "Temperate/Variable cold", constraints: [ { applies_to: :Temperature, uwp_slug_range: ["C","T"] }])
    row(roll: "Te", type: "Temperate", constraints: [ { applies_to: :Temperature, uwp_slug_range: ["T"] }])
    row(roll: "TW", type: "Temperate/Variable warm", constraints: [ { applies_to: :Temperature, uwp_slug_range: ["T", "H"] }])
    row(roll: "Wa",  type: "Warm",constraints: [ { applies_to: :Temperature, uwp_slug_range: ["H"] }])
    row(roll: "Bu", type: "Burning", constraints: [ { applies_to: :Temperature, uwp_slug_range: ["R"] }])
  end

  roller do
    case roll("2d6")
    when 2 then "Fr"
    when 3 then "Co"
    when 4,5 then "TC"
    when 6,7,8 then "Te"
    when 9,10 then "TW"
    when 11 then "Wa"
    when 12 then "Bu"
    end
  end
end
