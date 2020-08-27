require 'forwardable'
require 'twn/utility'
# From Journal of the Traveller's Aid Society: Volume 5
Twn::Attributes.register(:SecurityCodes, package: :Security) do
  table do
    row(roll: "Cr", name: "Corrupt")
    row(roll: "Co", name: "Covert")
    row(roll: "Fa", name: "Factionalised")
    row(roll: "Fo", name: "Focussed")
    row(roll: "Ip", name: "Impersonal")
    row(roll: "Mi", name: "Militarised")
    row(roll: "Pe", name: "Pervasive")
    row(roll: "Te", name: "Technological")
    row(roll: "Vo", name: "Volunteer")
  end

  roller do
    SecurityCodesRoller.call(context: self)
  end

  class SecurityCodesRoller
    def self.call(context:)
      new(context: context).call
    end

    def initialize(context:)
      @context = context
      @government = get!(:Government).roll
      @population = get!(:Population).roll
      @security_planetary = get!(:SecurityPlanetary).roll
      @trade_codes = get!(:TradeCodes).roll
      @tech_level = get!(:TechLevel).roll
    end
    extend Forwardable
    def_delegators :@context, :get!, :roll

    def call
      return [] if @population == 0
      [
        check_corrupt,
        check_covert,
        check_factionalised,
        check_focussed,
        check_impersonal,
        check_militarised,
        check_pervasive,
        check_technological,
        check_volunteer
      ].compact
    end

    private

    def check_corrupt
      return "Cr" if @population >= 4 &&
                     [1,3,5,6,7,8,9,11,13,14,15].include?(@government) &&
                     (1..5).include?(@security_planetary) &&
                     (@trade_codes.include?("Po") || @trade_codes.include?("Ri")) &&
                     roll("2d6") >= 12
      nil
    end

    def check_covert
      return "Co" if @population >= 6 &&
                     [1,3,6,8,9,11,13,14,15].include?(@government) &&
                     (1..5).include?(@security_planetary) &&
                     roll("2d6") >= 10
      nil
    end

    def check_factionalised
      return "Fa" if @population >= 5 &&
                     [4,5,6,9,11,12,13,14,15].include?(@government) &&
                     @security_planetary >= 5 &&
                     roll("2d6") >= 10
      nil
    end

    def check_focussed
      return "Fo" if @population >= 8 &&
                     [4,5,6,9,11,12,13,14,15].include?(@government) &&
                     (1..6).include?(@security_planetary)
      nil
    end

    def check_impersonal
      return nil if @population < 5
      return nil unless [1,3,6,9,13,14,15].include?(@government)
      if @government == 9
        return nil if roll("2d6") < 5
      else
        return nil if roll("2d6") < 10
      end
      "Ip"
    end

    def check_militarised
      return "Mi" if @population >= 4 &&
                     [3,5,6,7,11,15].include?(@government) &&
                     roll("2d6") >= 10
      nil
    end

    def check_pervasive
      return "Pe" if (1..9).include?(@population) &&
                     [1,5,6,7,8,9,11,13,14,15].include?(@government) &&
                     @security_planetary >= 7
      nil
    end

    def check_technological
      return "Te" if @tech_level >= 12
      nil
    end

    def check_volunteer
      return "Vo" if (1..2).include?(@population) &&
                     [2,3,4,7,10,12].include?(@government) &&
                     roll("2d6") >= 5
      nil
    end
  end
end
