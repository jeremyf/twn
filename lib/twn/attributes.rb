require 'twn/attribute_builder'
module Twn
  # This module is a container for all of the types of world attributes.
  #
  # @todo Refactor so that we are using an instance instead of a class
  module Attributes
    def self.register(attribute_name, &block)
      raise Error if registry.key?(attribute_name)
      registry[attribute_name] ||= AttributeBuilder.new(attribute_name: attribute_name, &block)
    end

    def self.registry
      @registry ||= {}
    end

    # Given the :generator roll :on the corresponding attribute to get a value.
    #
    # @param on [Symbol]
    # @param generator [Twn::Generator]
    # @return [Twn::Attribute]
    def self.roll(on:, generator:)
      roller_for(on).roll!(generator: generator)
    end

    def self.each(&block)
      registry.each_key(&block)
    end

    # @param on [Symbol]
    # @return [#roll!]
    def self.roller_for(class_name)
      registry.fetch(class_name)
    end

    def self.fetch(from:, uwp_slug:)
      roller_for(from).fetch_by_uwp_slug(uwp_slug)
    end
  end
end
Dir.glob(File.join(__dir__, "attributes", "*.rb")).each do |filename|
  require filename
end
