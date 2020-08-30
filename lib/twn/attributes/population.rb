Twn::Attributes.register(:Population, package: :Core) do
  table do
    (0..15).each do |i|
      row(roll: i, population: i == 0 ? "0" : "10^#{i}")
    end
  end
  roller { roll("2d6") - 2 }
end
