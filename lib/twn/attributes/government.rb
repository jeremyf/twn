require 'twn/attributes'
Twn::Attributes.register(:Government) do
  table do
    row(roll: 0, type: "None")
    row(roll: 1, type: "Company/corporation")
    row(roll: 2, type: "Participating democracy")
    row(roll: 3, type: "Self-perpetuating oligarchy")
    row(roll: 4, type: "Representative democracys")
    row(roll: 5, type: "Feudal technocracy")
    row(roll: 6, type: "Captive government")
    row(roll: 7, type: "Balkanisation")
    row(roll: 8, type: "Civil service bureaucracy")
    row(roll: 9, type: "Impersonal bureaucracy")
    row(roll: 10, type: "Charismatic dictator")
    row(roll: 11, type: "Non-charismatic leaderdictator")
    row(roll: 12, type: "Charismatic oligarchy")
    row(roll: 13, type: "Religious dictatorship")
  end

  roller do
    population = get!(:Population)
    if population.roll == 0
      0
    else
      roll("2d6", -7) + population.roll
    end
  end
end
