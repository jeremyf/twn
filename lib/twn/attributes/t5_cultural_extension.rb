Twn::Attributes.register(:T5CulturalExtensionHeterogeneity, package: :T5) do
  table do
    (0..18).each do |i|
      row(roll: i)
    end
  end
  roller do
    result = 0
    pop = get!(:Population).roll
    if pop > 0
      result = pop + roll("flux")
      result = 1 if result < 1
    end
    result
  end
end

Twn::Attributes.register(:T5CulturalExtensionAcceptance, package: :T5) do
  table do
    (0..18).each do |i|
      row(roll: i)
    end
  end
  roller do
    result = 0
    pop = get!(:Population).roll
    if pop > 0
      result = pop + get!(:T5ImportanceExtension)
      result = 1 if result < 1
    end
    result
  end
end

Twn::Attributes.register(:T5CulturalExtensionStrangeness, package: :T5) do
  table do
    (0..18).each do |i|
      row(roll: i)
    end
  end
  roller do
    result = 0
    pop = get!(:Population).roll
    if pop > 0
      result = roll("flux") + 5
      result = 1 if result < 1
    end
    result
  end
end

Twn::Attributes.register(:T5CulturalExtensionSymbols, package: :T5) do
  table do
    (0..18).each do |i|
      row(roll: i)
    end
  end
  roller do
    result = 0
    pop = get!(:Population).roll
    if pop > 0
      result = roll("flux") + get!(:TechLevel).roll
      result = 1 if result < 1
    end
    result
  end
end
