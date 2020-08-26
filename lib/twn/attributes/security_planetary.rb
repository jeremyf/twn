require 'forwardable'
require 'twn/utility'
# From Journal of the Traveller's Aid Society: Volume 5
Twn::Attributes.register(:SecurityPlanetary) do
  table do
    (0..15).each do |i|
      row(roll: i, description: "Security: Planetary presence #{i}")
    end

    to_uwp_slug do |row|
      if row[:population] == 0
        "·"
      else
        Twn::Utility.to_uwp_slug(row.roll)
      end
    end
  end

  roller do
    SecurityPlanetaryRoller.call(context: self)
  end

  class SecurityPlanetaryRoller
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
       roll("2d6", -7) +
        law_level_dm +
        size_dm +
        government_dm +
        trade_codes_dm
    end

    private

    def law_level_dm
      get!(:LawLevel).roll
    end

    def size_dm
      case get!(:Size).roll
      when 0,1 then 2
      when 2,3 then 1
      when 9,10,11,12,13,14,15 then -1
      else
        0
      end
    end

    def government_dm
      case get!(:Government).roll
      when 2,12 then -2
      when 7,10 then -1
      when 1,5,11 then 1
      when 6,13,14,15 then 2
      else
        0
      end
    end

    def trade_codes_dm
      trade_codes_to_uwp_slug = get!(:TradeCodes).to_uwp_slug
      return -2 if trade_codes_to_uwp_slug.include?("Hi")
      return -1 if trade_codes_to_uwp_slug.include?("Lo")
      return 1 if trade_codes_to_uwp_slug.include?("Ht")
      return 1 if trade_codes_to_uwp_slug.include?("Ri")
      0
    end
  end
end
