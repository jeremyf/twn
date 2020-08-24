require 'twn/attribute'
module Twn
  module Attributes
    class TradeCodes < Twn::CompositeAttribute
      initialize_table do
        add_row(roll: "Ag", classification: "Agricultural")
        add_row(roll: "As", classification: "Asteroid")
        add_row(roll: "Ba", classification: "Barren")
        add_row(roll: "De", classification: "Desert")
        add_row(roll: "Fl", classification: "Fluid Oceans")
        add_row(roll: "Ga", classification: "Garden")
        add_row(roll: "Hi", classification: "High Population")
        add_row(roll: "Ht", classification: "High Technology")
        add_row(roll: "IC", classification: "Ice-Capped")
        add_row(roll: "In", classification: "Industrial")
        add_row(roll: "Lo", classification: "Low Population")
        add_row(roll: "Lt", classification: "Low Technology")
        add_row(roll: "Na", classification: "Non-Agricultural")
        add_row(roll: "NI", classification: "Non-Industrial")
        add_row(roll: "Po", classification: "Poor")
        add_row(roll: "Ri", classification: "Rich")
        add_row(roll: "Va", classification: "Vacuum")
        add_row(roll: "Wa", classification: "Water")
      end

      def self.roll!(generator:)
        build(rolls: EntryBuilder.new(generator: generator).rolls)
      end

      class EntryBuilder
        def initialize(generator:)
          @generator = generator
        end
        attr_reader :generator

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
          entries = []
          TRADE_CODE_CONSTRAINTS.each_pair do |roll, constraints|
            entries << roll if meets?(constraints: constraints)
          end
          entries
        end

        private

        def meets?(constraints:)
          constraints.all? do |attribute_name, uwp_slug_range|
            attribute = generator.get!(attribute_name)
            Array(uwp_slug_range).map { |slug| Utility.to_uwp_slug(slug) }.include?(attribute.to_uwp_slug)
          end
        end
      end
    end
  end
end
