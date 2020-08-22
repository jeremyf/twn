require 'twn/attribute'
require 'psych'
module Twn
  module Attributes
    class Tags < Twn::Attribute
      # @todo The generated tags introduce possible constraints; Any
      #       added entry must meet the given constraints.
      def self.roll!(generator:)
        data = Psych.load(File.read(File.expand_path("../../../data/swn-tags.yml", __dir__)))
        tags = data.shuffle[0..1]
        new(entry: tags)
      end
    end
  end
end
