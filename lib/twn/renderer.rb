require 'twn/generator'
require 'twn/packages'
module Twn
  class Renderer
    DEFAULT_PACKAGES = [:Core, :Factions, :Security, :SWN]
    # @todo Use packages instead of the generator
    def initialize(generator: Generator.new, buffer: $stdout, packages: DEFAULT_PACKAGES)
      @generator = generator
      @buffer = buffer
      @packages = packages
    end
    attr_reader :generator, :buffer, :packages

    # @todo separate the modules
    def to_uwp
      string = packages.map do |package|
        Twn::Packages.render(package, generator: generator, format: :to_uwp).strip
      end.join(" ")
      buffer.puts string
    end
  end
end
