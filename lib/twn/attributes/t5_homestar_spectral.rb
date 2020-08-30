# From Traveller 5.10, Book 3, Page 24, Table 2A
Twn::Attributes.register(:T5HomestarSpectral) do
  table do
    row(roll: -6, to_uwp_slug: "O")
    row(roll: -5, to_uwp_slug: "OB")
    row(roll: -4, to_uwp_slug: "A")
    row(roll: -3, to_uwp_slug: "A")
    row(roll: -2, to_uwp_slug: "F")
    row(roll: -1, to_uwp_slug: "F")
    row(roll: 0, to_uwp_slug: "G")
    row(roll: 1, to_uwp_slug: "K")
    row(roll: 2, to_uwp_slug: "K")
    row(roll: 3, to_uwp_slug: "M")
    row(roll: 4, to_uwp_slug: "M")
    row(roll: 5, to_uwp_slug: "M")
    row(roll: 6, to_uwp_slug: "M")
  end

  roller { roll("flux") }
end
