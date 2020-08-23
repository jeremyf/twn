require "twn/version"
require "twn/generator"
require "twn/attributes"
require "twn/utility"
require "twn/constraint"
module Twn
  class Error < StandardError; end
  # Your code goes here...

  DEFAULT_SEQUENCE = [
    :Tags,
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
    :PirateBase
  ]
  def self.generate(sequence: DEFAULT_SEQUENCE)
    generator = Generator.new
    sequence.each do |attribute|
      generator.get!(attribute)
    end
    generator
  end
end
