require 'twn/attribute'
require 'psych'
module Twn
  module Attributes
    class Tags < Twn::Attribute
      def self.swn_tags
        @tags ||= Psych.load(File.read(File.expand_path("../../../data/swn-tags.yml", __dir__)))
      end
      # @todo The generated tags introduce possible constraints; Any
      #       added entry must meet the given constraints.
      def self.roll!(generator:, tags: swn_tags)
        applied_tags = tags.shuffle[0..1]
        new(entry: applied_tags)
      end
    end
  end
end
