require 'twn/packages'
module Twn
  class Renderer
    # @param generator [Twn::Generator]
    # @param buffer [#puts]
    # @param packages [Array<Symbol>]
    def initialize(generator: default_generator, buffer: $stdout, packages: DEFAULT_PACKAGES)
      @generator = generator
      @buffer = buffer
      @packages = packages
    end
    attr_reader :generator, :buffer, :packages

    DEFAULT_PACKAGES = [:Core, :Factions, :Security, :SWN]

    def default_generator
      require 'twn/generator'
      Generator.new
    end

    # @return String
    def to_uwp
      string = packages.map do |package|
        Twn::Packages.render(package, generator: generator, format: :to_uwp).strip
      end.join(" ")
      buffer.puts string
      string
    end
  end
end
