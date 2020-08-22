module Twn
  class Attribute
    def self.notation(dice: nil, modifier: 0)
      return @notation if dice.nil?
      @notation = { dice: dice, modifier: modifier }
    end

    def self.roll!(generator:, **args)
      raise(NotImplementedError.new("Override .roll! in sub-class"))
    end

    def key
      @entry.key
    end

    def notation
      self.class.notation
    end
  end
end
