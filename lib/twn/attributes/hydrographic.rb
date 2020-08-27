Twn::Attributes.register(:Hydrographic, package: :Core) do
  table do
    row(roll: 0, percentage:"0%-5%", description: "Desert world")
    row(roll: 1, percentage:"6%-15%", description: "Dry world")
    row(roll: 2, percentage:"16%-25%", description: "A few small seas")
    row(roll: 3, percentage:"25%-35%", description: "Small seas and oceans")
    row(roll: 4, percentage:"36%-45%", description: "Wet world")
    row(roll: 5, percentage:"46%-55%", description: "Large oceans")
    row(roll: 6, percentage:"56%-65%", description: "Large oceans and seas")
    row(roll: 7, percentage:"66%-75%", description: "Earth-like world")
    row(roll: 8, percentage:"76%-85%", description: "Water world")
    row(roll: 9, percentage:"86%-95%", description: "Only a few small islands and archipelagos")
    row(roll: 10, percentage:"96%-100%", description: "Almost entirely water.")
  end

  roller do
    size = get!(:Size)
    if ["0", "1"].include?(size.to_uwp_slug)
      0
    else
      roll("2d6", -7) +
        size.roll +
        HydrographicModifier.call(atmosphere: get!(:Atmosphere), temperature: get!(:Temperature))
    end
  end

  module HydrographicModifier
    TEMPERATURE_UWP_MODIFIER = {
      "H" => -2,
      "R" => -6,
    }

    ATMOSPHERE_UWP_MODIFIER = {
      "0" => -4,
      "1" => -4,
      "A" => -4,
      "B" => -4,
      "C" => -4,
    }

    def self.call(atmosphere:, temperature:)
      modifier = 0
      return modifier if atmosphere.to_uwp_slug == "D"

      modifier += TEMPERATURE_UWP_MODIFIER.fetch(temperature.to_uwp_slug, 0)
      modifier += ATMOSPHERE_UWP_MODIFIER.fetch(atmosphere.to_uwp_slug, 0)
      modifier
    end
  end
end
