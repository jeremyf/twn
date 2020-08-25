require "twn/version"
require "twn/generator"
require "twn/attributes"
require "twn/table"
require "twn/utility"
require "twn/constraint"
require "twn/renderer"
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
  def self.generate(sequence: DEFAULT_SEQUENCE)
    generator = Generator.new
    sequence.each do |attribute|
      generator.get!(attribute)
    end
    generator
  end
end
