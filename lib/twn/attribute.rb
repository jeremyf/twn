module Twn
  class Attribute
    def self.notation(dice=nil, modifier=nil, modified_by: [])
      return @notation if dice.nil?
      @notation = [dice, modifier, { modified_by: modified_by}]
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
