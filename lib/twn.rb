require "twn/version"
require "twn/error"
require "twn/generator"
require "twn/attributes"
require "twn/table"
require "twn/utility"
require "twn/constraint"
require "twn/renderer"
require "twn/attribute_builder"
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
    :TradeCodes,
    :SecurityPlanetary,
    :SecurityOrbital,
    :SecuritySystem,
    :SecurityStance,
    :SecurityCodes
  ]
  DEFAULT_SEQUENCE = [:SwnAtmosphere, :SwnTemperature, :SwnBiosphere, :SwnPopulation, :SwnWorldTags] + TRAVELLER_SEQUENCE
  def self.generate(sequence: DEFAULT_SEQUENCE, buffer: $stdout)
    generator = Generator.new
    sequence.each do |attribute|
      generator.get!(attribute)
    end
    Renderer.new(generator: generator, buffer: buffer).to_uwp
    generator
  end
end
