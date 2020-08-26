Twn::Attributes.register(:Atmosphere) do
  table do
    row(roll: 0, atmosphere: "None")
    row(roll: 1, atmosphere: "Trace")
    row(roll: 2, atmosphere: "Very Thin, Tainted")
    row(roll: 3, atmosphere: "Very Thin")
    row(roll: 4, atmosphere: "Thin, Tainted")
    row(roll: 5, atmosphere: "Thin")
    row(roll: 6, atmosphere: "Standard")
    row(roll: 7, atmosphere: "Standard, Tainted")
    row(roll: 8, atmosphere: "Dense")
    row(roll: 9, atmosphere: "Dense, Tainted")
    row(roll: 10, atmosphere: "Exotic")
    row(roll: 11, atmosphere: "Corrosive")
    row(roll: 12, atmosphere: "Insidious")
    row(roll: 13, atmosphere: "Dense, High")
    row(roll: 14, atmosphere: "Thin, Low")
    row(roll: 15, atmosphere: "Unusual")
  end

  roller { roll("2d6", -7) + get!(:Size).roll }
end
