require "twn/version"
require "twn/generator"
require "twn/attributes"
require "twn/table"
require "twn/utility"
require "twn/constraint"
require "twn/renderer"
require "twn/attribute_builder"
module Twn
  class Error < StandardError; end

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
  DEFAULT_SEQUENCE = [:SwnWorldTags] + TRAVELLER_SEQUENCE
  def self.generate(sequence: DEFAULT_SEQUENCE, buffer: $stdout)
    generator = Generator.new
    sequence.each do |attribute|
      generator.get!(attribute)
    end
    Renderer.new(generator: generator, buffer: buffer).to_uwp
    generator
  end
end
