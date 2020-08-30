# Extrapolated from T5.10, Book 3, p24, table 2B
Twn::Attributes.register(:T5PlanetoidBelts, package: :T5) do
  table do
    row(roll: 0)
    row(roll: 1)
    row(roll: 2)
    row(roll: 3)
  end
  roller { roll("1d6") - 3  }
end
