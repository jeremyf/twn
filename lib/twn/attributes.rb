Dir.glob(File.join(__dir__, "attributes", "*.rb")).each do |filename|
  require filename
end
module Twn
  # This module is a container for all of the types of world attributes.
  module Attributes
    # Given the :generator roll :on the corresponding attribute to get a value.
    #
    # @param on [Symbol]
    # @param generator [Twn::Generator]
    # @return [Twn::Attribute]
    def self.roll(on:, generator:)
      roller_for(on).roll!(generator: generator)
    end

    def self.each(&block)
      constants.each(&block)
    end

    # @param on [Symbol]
    # @return [#roll!]
    def self.roller_for(class_name)
      const_get(class_name)
    end
  end
end
