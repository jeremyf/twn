require 'twn/attributes'
Twn::Attributes.register(:TradeCodes) do
  table do
    row(roll: "Ag", classification: "Agricultural")
    row(roll: "As", classification: "Asteroid")
    row(roll: "Ba", classification: "Barren")
    row(roll: "De", classification: "Desert")
    row(roll: "Fl", classification: "Fluid Oceans")
    row(roll: "Ga", classification: "Garden")
    row(roll: "Hi", classification: "High Population")
    row(roll: "Ht", classification: "High Technology")
    row(roll: "IC", classification: "Ice-Capped")
    row(roll: "In", classification: "Industrial")
    row(roll: "Lo", classification: "Low Population")
    row(roll: "Lt", classification: "Low Technology")
    row(roll: "Na", classification: "Non-Agricultural")
    row(roll: "NI", classification: "Non-Industrial")
    row(roll: "Po", classification: "Poor")
    row(roll: "Ri", classification: "Rich")
    row(roll: "Va", classification: "Vacuum")
    row(roll: "Wa", classification: "Water")
  end

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
      "NI" => { Population: (4..6) },
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
      constraints.all? do |attribute_name, uwp_slug_range|
        attribute = get!(attribute_name)
        Array(uwp_slug_range).map { |slug| to_uwp_slug(slug) }.include?(attribute.to_uwp_slug)
      end
    end
  end
end
