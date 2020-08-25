require 'twn/attributes'
Twn::Attributes.register(:Starport) do
  table do
    row(roll: 2, to_uwp_slug: "X", description: "No Starport")
    row(roll: 3, to_uwp_slug: "E", description: "Frontier")
    row(roll: 4, to_uwp_slug: "E", description: "Frontier")
    row(roll: 5, to_uwp_slug: "D", description: "Poor")
    row(roll: 6, to_uwp_slug: "D", description: "Poor")
    row(roll: 7, to_uwp_slug: "C", description: "Routine")
    row(roll: 8, to_uwp_slug: "C", description: "Routine")
    row(roll: 9, to_uwp_slug: "B", description: "Good")
    row(roll: 10, to_uwp_slug: "B", description: "Good")
    row(roll: 11, to_uwp_slug: "A", description: "Excellent")
    row(roll: 12, to_uwp_slug: "A", description: "Excellent")
  end

  roller { roll("2d6") }
end
