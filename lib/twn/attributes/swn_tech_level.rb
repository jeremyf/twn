Twn::Attributes.register(:SwnTechLevel) do
  table do
    row(roll: "TL0", constraints: [ { applies_to: :TechLevel, uwp_slug_range: [0,1] }])
    row(roll: "TL1", constraints: [ { applies_to: :TechLevel, uwp_slug_range: [2,3] }])
    row(roll: "TL2", constraints: [ { applies_to: :TechLevel, uwp_slug_range: [4,5,6] }])
    row(roll: "TL3", constraints: [ { applies_to: :TechLevel, uwp_slug_range: [7,8,9] }])
    row(roll: "TL4", constraints: [ { applies_to: :TechLevel, uwp_slug_range: [10,11,12] }])
    row(roll: "TL4+", constraints: [ { applies_to: :TechLevel, uwp_slug_range: [13,14] }])
    row(roll: "TL5", constraints: [ { applies_to: :TechLevel, uwp_slug_range: [15] }])
  end

  roller do
    case roll("2d6")
    when 2 then "TL0"
    when 3 then "TL1"
    when 4,5 then "TL2"
    when 6,7,8 then "T4"
    when 9,10 then "T3"
    when 11 then "TL4+"
    when 12 then "TL5"
    end
  end
end
