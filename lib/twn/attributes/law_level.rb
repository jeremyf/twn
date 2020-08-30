Twn::Attributes.register(:LawLevel, package: :Core) do
  table do
    (0..15).each do |i|
      row(roll: i, description: "Law level #{i}")
    end
  end

  roller do
    population = get!(:Population)
    if population.roll == 0
      0
    else
      roll("2d6") - 7 + get!(:Government).roll
    end
  end
end
