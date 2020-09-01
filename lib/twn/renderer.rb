require 'twn/generator'
require 'twn/packages'
module Twn
  class Renderer
    # @todo Use packages instead of the generator
    def initialize(generator: Generator.new, buffer: $stdout)
      @generator = generator
      @buffer = buffer
    end
    attr_reader :generator, :buffer

    # @todo separate the modules
    def to_uwp
      string = [:Core, :Security, :SWN].map do |package_name|
        Twn::Packages.render(package_name, generator: generator, format: :to_uwp)
      end.join(" ")
      buffer.puts string
    end
  end
end
