Twn::Attributes.register(:SwnAtmosphere) do
  table do
    row(roll: "Co", type: "Corrosive", constraints: [ { applies_to: :Atmosphere, uwp_slug_range: [11,15] }])
    row(roll: "Ir", type: "Inert", constraints: [ { applies_to: :Atmosphere, uwp_slug_range: [4,10,7,9] }])
    row(roll: "AT", type: "Airless or Thin", constraints: [ { applies_to: :Atmosphere, uwp_slug_range: [0,1,2,3,4,5,15] }])
    row(roll: "Br", type: "Breathable", constraints: [ { applies_to: :Atmosphere, uwp_slug_range: [5,6,8,13,14,15] }])
    row(roll: "Th", type: "Thick", constraints: [ { applies_to: :Atmosphere, uwp_slug_range: [8,9,13,15] }])
    row(roll: "Iv", type: "Invasive", constraints: [ { applies_to: :Atmosphere, uwp_slug_range: [12,15] }])
    row(roll: "CI", type: "Corrosive and Invasive", constraints: [ { applies_to: :Atmosphere, uwp_slug_range: [15,11,12] }])
  end

  roller do
    case roll("2d6")
    when 2 then "Co"
    when 3 then "Ir"
    when 4 then "AT"
    when 5,6,7,8,9 then "Br"
    when 10 then "Th"
    when 11 then "Iv"
    when 12 then "CI"
    end
  end
end
