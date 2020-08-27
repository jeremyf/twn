require 'forwardable'
require 'twn/utility'
# From Journal of the Traveller's Aid Society: Volume 5
Twn::Attributes.register(:SecurityStance, package: :Security) do
  table do
    (0..15).each do |i|
      row(roll: i, description: "Security: System presence #{i}")
    end

    to_uwp_slug do |row|
      if row[:population] == 0
        "·"
      elsif row[:government] == 7
        # Balkanized government
        "B#{Twn::Utility.to_uwp_slug(row.roll)}"
      else
        Twn::Utility.to_uwp_slug(row.roll)
      end
    end

    # @todo Add from_uwp_slug to handle Balkanization
  end

  roller do
    SecuritySystemRoller.call(context: self)
  end

  class SecuritySystemRoller
    def self.call(context:)
      new(context: context).call
    end

    def initialize(context:)
      @context = context
    end
    extend Forwardable
    def_delegators :@context, :get!, :roll

    def call
      return { roll: 0, population: 0 } if get!(:Population).roll == 0
      return 0 if get!(:Government).roll == 0
      return 0 if get!(:LawLevel).roll == 0
      result = roll("2d6", -7) +
               law_level_dm +
               starport_dm +
               government_dm +
               trade_codes_dm +
               gas_giants_dm
      return result if get!(:Government).roll != 7
      { roll: result, government: 7 }
    end

    private

    def law_level_dm
      get!(:LawLevel).roll
    end

    def orbital_presence_dm
      get!(:SecurityOrbital).roll
    end

    def starport_dm
      return 2 if get!(:Starport).to_uwp_slug == "X"
      0
    end

    def government_dm
      case get!(:Government).roll
      when 2, 12 then -2
      when 10 then -1
      when 1, 5, 11 then 1
      when 6, 13, 14, 15 then 2
      else
        0
      end
    end

    def trade_codes_dm
      trade_codes_to_uwp_slug = get!(:TradeCodes).to_uwp_slug
      return -2 if trade_codes_to_uwp_slug.include?("Hi")
      return -1 if trade_codes_to_uwp_slug.include?("Ht")
      return 1 if trade_codes_to_uwp_slug.include?("Lt")
      0
    end
  end
end
