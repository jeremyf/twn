# Extrapolated from T5.10, Book 3, p27
Twn::Attributes.register(:T5EconomicExtensionResources, package: :T5) do
  table do
    (0..19).each do |i|
      row(roll: i)
    end
  end
  roller do
    roll_result = roll("2d6")
    if get!(:TechLevel).roll >= 8
      roll_result += get!(:T5GasGiants).roll + get!(:T5PlanetoidBelts).roll
    end

    roll_result
  end
end

Twn::Attributes.register(:T5EconomicExtensionLabor, package: :T5) do
  table do
    (0..17).each do |i|
      row(roll: i)
    end
  end
  roller do
    pop = get!(:Population).roll
    if pop == 0
      0
    else
      pop - 1
    end
  end
end

Twn::Attributes.register(:T5EconomicExtensionInfrastructure, package: :T5) do
  table do
    (0..17).each do |i|
      row(roll: i)
    end
  end
  roller do
    pop = get!(:Population).roll
    case pop
    when 0 then 0
    when (1..3) then get!(:T5ImportanceExtension).roll
    when (4..6) then roll("1d6") + get!(:T5ImportanceExtension).roll
    else
      roll("2d6") + get!(:T5ImportanceExtension).roll
    end
  end
end

Twn::Attributes.register(:T5EconomicExtensionEfficiency, package: :T5) do
  table do
    (-5..5).each do |i|
      row(roll: i)
    end
  end
  roller { roll("flux") }
end
