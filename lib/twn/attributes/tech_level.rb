require 'twn/config'
Twn::Attributes.register(:TechLevel, package: :Core) do
  table do
    (0..Twn::Config::DEFAULT_MAX_TECH_LEVEL).each do |i|
      row(roll: i, description: "Tech level #{i}")
    end
  end

  roller { Builder.new(context: self).call }

  class Builder
    def initialize(context:)
      @context = context
    end

    extend Forwardable
    def_delegators :@context, :get!, :roll

    def call(ttl: 10)
      population = get!(:Population)
      return 0 if population.roll == 0
      roll_result = nil
      threshold_met = false
      while ttl > 0 && !threshold_met
        roll_result = roll("1d6") +
               starport_dm +
               size_dm +
               atmosphere_dm +
               hydro_dm +
               population_dm +
               government_dm
        threshold_met = (roll_result >= threshold)
        ttl -= 1
      end
      roll_result = threshold if ttl == 0
      return roll_result
    end

    private

    def starport_dm
      case get!(:Starport).to_uwp_slug
      when "A" then 6
      when "B" then 4
      when "C" then 2
      when "X" then -4
      else
        0
      end
    end

    def size_dm
      case get!(:Size).to_uwp_slug
      when "0", "1" then 2
      when "2", "3", "4" then 1
      else
        0
      end
    end

    def atmosphere_dm
      case get!(:Atmosphere).to_uwp_slug
      when "0", "1", "2", "3", "A", "B", "C", "D", "E", "F" then 1
      else
        0
      end
    end

    def hydro_dm
      case get!(:Hydrographic).to_uwp_slug
      when "0", "9" then 1
      when "A" then 2
      else
        0
      end
    end

    def population_dm
      case get!(:Population).to_uwp_slug
      when "1", "2", "3", "4", "5", "9" then 1
      when "A" then 2
      when "B" then 3
      when "C" then 4
      else
        0
      end
    end

    def government_dm
      case get!(:Government).to_uwp_slug
      when "0", "5" then 1
      when "7" then 2
      when "D", "E" then -2
      else
        0
      end
    end

    def threshold
      @threshold ||= begin
                       case get!(:Atmosphere).to_uwp_slug
                       when "0", "1" then 8
                       when "2", "3" then 5
                       when "4", "7", "9" then 3
                       when "A" then 8
                       when "B" then 9
                       when "C" then 10
                       when "D", "E" then 5
                       when "F" then 8
                       else
                         0
                       end
                     end
    end
  end
end
