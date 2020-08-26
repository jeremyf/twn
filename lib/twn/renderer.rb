require 'twn/generator'
module Twn
  class Renderer
    BASES = [
      :NavalBase,
      :ScoutBase,
      :ResearchBase,
      :TravellersAidSociety,
      :ImperialConsulate,
      :PirateBase,
      :GasGiant
    ]
    def initialize(generator: Generator.new, buffer: $stdout, bases: BASES)
      @generator = generator
      @buffer = buffer
      @bases = bases
    end
    attr_reader :generator, :buffer, :bases

    def to_uwp
      tags = generator.get!(:SwnWorldTags)

      prefix = [
        :Starport,
        :Size,
        :Atmosphere,
        :Hydrographic,
        :Population,
        :Government,
        :LawLevel
      ].map do |attribute_name|
        generator.get!(attribute_name).to_uwp_slug
      end.join("")
      tech_level = generator.get!(:TechLevel)

      trade_codes = generator.get!(:TradeCodes)

      base_codes = bases.map { |base| generator.get!(base).to_uwp_slug }.join.strip

      travel_code = generator.get!(:TravelCode)

      factions = generator.get!(:Factions)
      line = sprintf("%s-%-2d %#{bases.count}s %14s %2s [%s %s]", prefix, tech_level.roll, base_codes, trade_codes.to_uwp_slug, travel_code.to_uwp_slug, factions.to_uwp_slug, tags.to_uwp_slug)
      buffer.puts(line)
    end
  end
end
