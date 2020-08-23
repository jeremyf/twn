require 'twn/utility'
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
      prefix = [
        :Starport,
        :Size,
        :Atmosphere,
        :Hydrographic,
        :Population,
        :Government,
        :LawLevel
      ].map do |attribute_name|
        Utility.to_uwp_slug(generator.get!(attribute_name))
      end.join("")
      tech_level = Utility.to_uwp_slug(generator.get!(:TechLevel))

      base_codes = bases.map { |a| Utility.to_uwp_slug(generator.get!(a)) }.join.strip

      line = sprintf("%s-%-2d %#{bases.count}s", prefix, tech_level, base_codes)
      buffer.puts(line)
    end
  end
end