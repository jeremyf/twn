require "twn/version"
require "twn/config"
module Twn

  # @api public
  # @since v0.2.0
  #
  # An array of the available packages to build your TWN world.
  #
  # @example
  #   Twn.available_package_names.include?(:Core)
  #   => true
  #
  # @return [Array<Symbol>]
  # @see Twn::Attributes.packages
  #
  # @todo Extract :CoreBases into separate package, this makes it
  #       easier for rendering
  def self.available_package_names
    require 'twn/attributes'
    Attributes.packages.keys.sort
  end

  def self.config(&configuration)
    @config ||= Config.new(&configuration)
  end

  # @param packages [Array<Symbol>]
  # @param generator [Twn::Generator]
  #
  # @note The order of the given packages may matter.  The :Core
  #       package before :SWN would mean that the generator would not
  #       apply any of the :SWN constraints to the :Core attribute
  #       generation.
  #
  # @raise [KeyError] on an unregistered package name
  def self.generate(packages: config.package_generation_sequence, generator: default_generator)
    packages.each do |package|
      Attributes.packages.fetch(package).each do |attribute|
        generator.get!(attribute)
      end
    end
    generator
  end

  def self.default_generator
    require "twn/generator"
    Generator.new
  end
end
