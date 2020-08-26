Twn::Attributes.register(:GasGiant) do
  table do
    row(roll: "", description: "No gas giant")
    row(roll: "G", description: "Gas giant")
  end

  roller { roll("2d6") < 10 ? "" : "G" }
end
