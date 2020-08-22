module Twn
  class Attribute
    def self.table=(hash)
      @table = hash
    end
    def self.table
      @table
    end

    def self.build(roll:)
      roll = table.keys.min if table.keys.min > roll
      roll = table.keys.max if table.keys.max < roll
      entry = table.fetch(roll)
      new(entry: entry)
    end

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
