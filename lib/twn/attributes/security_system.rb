require 'forwardable'
require 'twn/utility'
# From Journal of the Traveller's Aid Society: Volume 5
Twn::Attributes.register(:SecuritySystem, package: :Security) do
  table do
    (0..15).each do |i|
      row(roll: i, description: "Security: System presence #{i}")
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
      return 0 if get!(:Starport).to_uwp_slug == "X"
      return 0 if get!(:Government).roll == 0
      return 0 if get!(:LawLevel).roll == 0
      roll("2d6") -7 +
        orbital_presence_dm +
        starport_dm +
        government_dm +
        trade_codes_dm +
        gas_giants_dm
    end

    private

    def orbital_presence_dm
      get!(:SecurityOrbital).roll
    end

    def starport_dm
      case get!(:Starport).to_uwp_slug
      when "E" then -2
      when "C", "D" then -1
      when "A" then 1
      else
        0
      end
    end

    def government_dm
      case get!(:Government).roll
      when 7 then -2
      when 1,9,10,12 then -1
      when 6 then 2
      else
        0
      end
    end

    def trade_codes_dm
      trade_codes_to_uwp_slug = get!(:TradeCodes).to_uwp_slug
      return -2 if trade_codes_to_uwp_slug.include?("Lo")
      return -2 if trade_codes_to_uwp_slug.include?("Po")
      return -1 if trade_codes_to_uwp_slug.include?("Lt")
      return -1 if trade_codes_to_uwp_slug.include?("Ni")
      return 1 if trade_codes_to_uwp_slug.include?("Ri")
      0
    end

    def gas_giants_dm
      return -2 if get!(:GasGiant).roll == ""
      0
    end
  end
end
