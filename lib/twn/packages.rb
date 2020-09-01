module Twn
  module Packages
    def self.register(package_name, &configuration)
      @registry ||= {}
      @registry[package_name] = Builder.new(name: package_name, &configuration)
    end

    # @since 0.2.0
    #
    # @param package_name [Symbol]
    # @param generator [Twn::Generator]
    # @param format [Symbol]
    #
    # Render a registered format.
    def self.render(package_name, generator:, format:)
      @registry.fetch(package_name).render(generator: generator, format: format)
    end

    class Builder
      def initialize(name:, &configuration)
        @name = name
        instance_exec(&configuration)
      end

      def render(generator:, format:)
        Renderer.new(generator: generator).render(&send(format))
      end

      private

      def method_missing(method_name, callable = nil, *args, &block)
        if method_name.start_with?("to_")
          return instance_variable_get("@#{method_name}") unless instance_variable_get("@#{method_name}").nil?
          raise Error if callable && block_given?
          raise Error if !callable && !block_given?
          instance_variable_set("@#{method_name}", callable || block)
        else
          super(callable, *args, &block)
        end
      end
    end

    class Renderer < BasicObject
      def initialize(generator:)
        @generator = generator
      end

      def render(&block)
        instance_exec(&block)
      end

      def sprintf(*args)
        ::Kernel.sprintf(*args)
      end

      def get!(*args)
        @generator.get!(*args)
      end
    end
  end
end
Dir.glob(File.join(__dir__, "packages", "*.rb")).each do |filename|
  require filename
end
