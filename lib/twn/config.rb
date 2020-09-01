module Twn
  class Config
    DEFAULT_MAX_TECH_LEVEL = 20
    DEFAULT_PACKAGE_GENERATION_SEQUENCE = [:T5, :SWN, :Core, :Security, :Factions]

    def initialize
      @max_tech_level = DEFAULT_MAX_TECH_LEVEL
      @package_generation_sequence = DEFAULT_PACKAGE_GENERATION_SEQUENCE
      yield(self) if block_given?
    end
    attr_accessor :package_generation_sequence
    attr_accessor :max_tech_level
  end
end
