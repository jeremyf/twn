# TODO: Add back gravity
Twn::Attributes.register(:Size, package: :Core) do
  table do
    (0..15).each do |i|
      row(roll: i, description: (i == 0 ? "Asteroid Belt" : "#{i},000 miles diameter"))
    end
  end

  roller { roll("2d6") - 2 }
end
