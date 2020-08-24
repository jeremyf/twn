require 'twn/attribute'
require 'psych'
module Twn
  module Attributes
    class SwnWorldTags < Twn::CompositeAttribute
      def self.swn_tags
        @swn_tags ||= Psych.load(File.read(File.expand_path("../../../data/swn-tags.yml", __dir__)))
      end

      initialize_table do |table|
        swn_tags.each_with_index do |tag, i|
          table.add_row(roll: i+1, **tag)
        end
      end

      # Given a list of :tags, randomly :pick from the list of :tags.
      # For each of the :tags, add each associated constraint to the
      # given :generator.
      #
      # @param generator [Twn::Generator]
      # @param pick [Integer]
      # @param tags [Array]
      #
      # @return Twn::Attributes::Tags
      def self.roll!(generator:, pick: 2, tags: @table)
        applied_tags = tags.shuffle[0..(pick - 1)]
        applied_tags.each do |tag|
          Array(tag[:constraints]).each do |constraint|
            generator.add_constraint!(**constraint)
          end
        end
        new(entries: applied_tags)
      end
    end
  end
end
