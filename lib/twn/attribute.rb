module Twn
  class Attribute
    def self.roll!(generator:, **args)
      raise(NotImplementedError.new("Override .roll! in sub-class"))
    end

    def key
      @entry.key
    end
  end
end
