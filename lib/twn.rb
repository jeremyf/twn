require "twn/version"
require "twn/generator"
require "twn/renderer"
module Twn

  TRAVELLER_SEQUENCE = [
    :Size,
    :Atmosphere,
    :Temperature,
    :Hydrographic,
    :Population,
    :Government,
    :LawLevel,
    :Factions,
    :Starport,
    :TechLevel,
    :NavalBase,
    :ScoutBase,
    :TravellersAidSociety,
    :ResearchBase,
    :ImperialConsulate,
    :PirateBase,
    :GasGiant,
    :TravelCode,
    :TradeCodes
  ]

  TRAVELLER_SECURITY_SEQUENCE = [
    :SecurityPlanetary,
    :SecurityOrbital,
    :SecuritySystem,
    :SecurityStance,
    :SecurityCodes
  ]

  STARS_WITHOUT_NUMBER_SEQUENCE = [
    :SwnAtmosphere,
    :SwnTemperature,
    :SwnBiosphere,
    :SwnPopulation,
    :SwnWorldTags
  ]

  MAP = {
    stars_without_number: STARS_WITHOUT_NUMBER_SEQUENCE,
    traveller_security: TRAVELLER_SECURITY_SEQUENCE,
    traveller: TRAVELLER_SEQUENCE
  }

  def self.generate(sources: MAP.keys, buffer: $stdout)
    sequence = sources.map { |s| MAP.fetch(s) }.flatten
    generator = Generator.new
    sequence.each do |attribute|
      generator.get!(attribute)
    end
    Renderer.new(generator: generator, buffer: buffer).to_uwp if buffer
    generator
  end
end
