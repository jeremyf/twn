module Twn
  module Config
    def self.max_tech_level
      @max_tech_level = 20
    end

    def self.max_tech_level=(input)
      @max_tech_level = input
    end
  end
end
