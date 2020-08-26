Twn::Attributes.register(:SwnPopulation) do
  table do
    row(roll: "FC", type: "Failed colony", constraints: [ { applies_to: :Population, uwp_slug_range: [0,1,2] }])
    row(roll: "Ou", type: "Outpost", constraints: [ { applies_to: :Population, uwp_slug_range: [2,3,4] }])
    row(roll: "FM", type: "Fewer than a million", constraints: [ { applies_to: :Population, uwp_slug_range: [3,4,5,6] }])
    row(roll: "SM", type: "Several million", constraints: [ { applies_to: :Population, uwp_slug_range: [5,6,7,8] }])
    row(roll: "HM", type: "Hundreds of millions", constraints: [ { applies_to: :Population, uwp_slug_range: [7,8,9] }])
    row(roll: "Bi", type: "Billions", constraints: [ { applies_to: :Population, uwp_slug_range: [8,9,10,11,12] }])
    row(roll: "Al", type: "Aliens", constraints: [ { applies_to: :Population, uwp_slug_range: (0..12).to_a }])
  end

  roller do
    case roll("2d6")
    when 2 then "FC"
    when 3 then "Ou"
    when 4,5 then "FM"
    when 6,7,8 then "SM"
    when 9,10 then "HM"
    when 11 then "Bi"
    when 12 then "Al"
    end
  end
end
