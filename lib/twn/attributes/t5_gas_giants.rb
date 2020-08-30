# From Traveller 5.10, Book 3, Page 24, Table 4G
Twn::Attributes.register(:T5GasGiants) do
  table do
    row(roll: 0, constraints: [{ applies_to: :GasGiant, uwp_slug_range: [""] }])
    row(roll: 1, constraints: [{ applies_to: :GasGiant, uwp_slug_range: ["G"] }])
    row(roll: 2, constraints: [{ applies_to: :GasGiant, uwp_slug_range: ["G"] }])
    row(roll: 3, constraints: [{ applies_to: :GasGiant, uwp_slug_range: ["G"] }])
    row(roll: 4, constraints: [{ applies_to: :GasGiant, uwp_slug_range: ["G"] }])
  end

  roller do
    roll("2d6") / 2 - 2
  end
end
