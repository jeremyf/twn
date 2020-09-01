Twn::Attributes.register(:TradeCodes, package: :Core) do
  table do
    row(roll: "Ag", classification: "Agricultural") # T5
    row(roll: "As", classification: "Asteroid") # T5
    row(roll: "Ba", classification: "Barren") # T5
    row(roll: "De", classification: "Desert") # T5
    row(roll: "Fl", classification: "Fluid Oceans") # T5
    row(roll: "Ga", classification: "Garden") # T5
    row(roll: "Hi", classification: "High Population") # T5
    row(roll: "Ht", classification: "High Technology") # T5
    row(roll: "IC", classification: "Ice-Capped") # T5
    row(roll: "In", classification: "Industrial") # T5
    row(roll: "Lo", classification: "Low Population") # T5
    row(roll: "Lt", classification: "Low Technology")
    row(roll: "Na", classification: "Non-Agricultural") # T5
    row(roll: "Ni", classification: "Non-Industrial") # T5
    row(roll: "Po", classification: "Poor") # T5
    row(roll: "Ri", classification: "Rich") # T5
    row(roll: "Va", classification: "Vacuum") # T5
    row(roll: "Wa", classification: "Water world") # T5
  end

  # row(roll: "He", classification: "Hellworld")
  # row(roll: "Oc", classification: "Ocean World")
  # row(roll: "Sa", classification: "Satellite")
  # row(roll: "Lk", classification: "Locked")
  # row(roll: "Di", classification: "Dieback")
  # row(roll: "Ba", classification: "Barren")
  # row(roll: "Ph", classification: "Pre-High")
  # row(roll: "Pa", classification: "Pre-Agricultural")
  # row(roll: "Px", classification: "Prison or Exile Camp")
  # row(roll: "Pi", classification: "Pre-Industrial")
  # row(roll: "Pr", classification: "Pre-Rich")
  # row(roll: "Fr", classification: "Frozen")
  # row(roll: "Ho", classification: "Hot")
  # row(roll: "Co", classification: "Cold")
  # row(roll: "Tr", classification: "Tropic")
  # row(roll: "Tu", classification: "Tundra")
  # row(roll: "Tz", classification: "Twilight Zone")

  roller { TradeCodesBuilder.new(context: self).rolls }

  class TradeCodesBuilder
    def initialize(context:)
      @context = context
    end
    extend Forwardable
    def_delegators :@context, :get!, :roll, :to_uwp_slug

    # Why 15?  Because those are hex code E.
    TRADE_CODE_CONSTRAINTS = {
      "Ag" => { Atmosphere: (4..9), Hydrographic: (4..8), Population: (5..7) },
      "As" => { Size: 0, Atmosphere: 0, Hydrographic: 0 },
      "Ba" => { Population: 0, Government: 0, TechLevel: 0 },
      "De" => { Atmosphere: (2..15), Hydrographic: 0 },
      "Fl" => { Atmosphere: (10..15), Hydrographic: (1..15) },
      "Ga" => { Size: (5..15), Atmosphere: (4..9), Hydrographic: (4..8) },
      "Hi" => { Population: (9..15) },
      "Ht" => { TechLevel: (12..15) },
      "IC" => { Atmosphere: (0..1), Hydrographic: (1..15) },
      "In" => { Atmosphere: [0, 1, 2, 4, 7, 9], Population: (9..15) },
      "Lo" => { Population: (1..3) },
      "Lt" => { TechLevel: (0..5) },
      "Na" => { Atmosphere: (0..3), Hydrographic: (0..3), Population: (6..15) },
      "Ni" => { Population: (4..6) },
      "Po" => { Atmosphere: (2..5), Hydrographic: (0..3) },
      "Ri" => { Atmosphere: [6, 8], Population: (6..8) },
      "Va" => { Atmosphere: 0 },
      "Wa" => { Hydrographic: 10 }
    }

    def rolls
      uwp_slugs = []
      TRADE_CODE_CONSTRAINTS.each_pair do |uwp_slug, constraints|
        uwp_slugs << uwp_slug if meets?(constraints: constraints)
      end
      uwp_slugs
    end

    private

    def meets?(constraints:)
      constraints.all? do |name, uwp_slug_range|
        attribute = get!(name)
        Array(uwp_slug_range).map { |slug| to_uwp_slug(slug) }.include?(attribute.to_uwp_slug)
      end
    end
  end
end
