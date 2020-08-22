require 'twn/attribute'
module Twn
  module Attributes
    # The Tech Law Level of the world
    class TechLevel < Twn::Attribute
      Entry = Struct.new(:key, :level)
      a_table = {}
      (0..15).each do |i|
        a_table[i] = Entry.new(i, "Level #{i}")
      end
      self.table = a_table

      def self.roll!(generator:)
        Builder.new(generator: generator, tech_level_builder: self).build
      end

      class Builder
        def initialize(generator:, tech_level_builder:)
          @generator = generator
          @tech_level_builder = tech_level_builder
        end
        attr_reader :generator, :tech_level_builder

        def build
          population = generator.fetch(:Population)
          if population.to_i == 0
            tech_level_builder.build(roll: 0)
          else
            roll = nil
            threshold_met = false
            ttl = 0
            while ttl > 0 && !threshold_met
              roll = generator.roll("1d6") +
                     starport_dm +
                     size_dm +
                     atmosphere_dm +
                     hydro_dm +
                     population_dm +
                     government_dm
              threshold_met = (roll >= threshold)
              ttl -= 1
            end
            roll = threshold if ttl == 0
            tech_level_builder.build(roll: roll)
          end
        end

        def starport_dm
          case generator.fetch(:Starport).to_uwp
          when "A" then 6
          when "B" then 4
          when "C" then 2
          when "X" then -4
          else
            0
          end
        end

        def size_dm
          case generator.fetch(:Size).to_uwp
          when "0", "1" then 2
          when "2", "3", "4" then 1
          else
            0
          end
        end

        def atmosphere_dm
          case generator.fetch(:Atmosphere).to_uwp
          when "0", "1", "2", "3", "A", "B", "C", "D", "E", "F" then 1
          else
            0
          end
        end

        def hydro_dm
          case generator.fetch(:Hydrographic).to_uwp
          when "0", "9" then 1
          when "A" then 2
          else
            0
          end
        end

        def population_dm
          case generator.fetch(:Population).to_uwp
          when "1", "2", "3", "4", "5", "9" then 1
          when "A" then 2
          when "B" then 3
          when "C" then 4
          else
            0
          end
        end

        def government_dm
          case generator.fetch(:Government).to_uwp
          when "0", "5" then 1
          when "7" then 2
          when "D", "E" then -2
          else
            0
          end
        end

        def threshold
          @threshold ||= begin
                           case atmosphere.to_uwp
                           when "0", "1" then 8
                           when "2", "3" then 5
                           when "4", "7", "9" then 3
                           when "A" then 8
                           when "B" then 9
                           when "C" then 10
                           when "D", "E" then 5
                           when "F" then 8
                           else
                             0
                           end
                         end
        end

        def atmosphere
          generator.fetch(:Atmosphere)
        end
      end
      private_constant :Builder
    end
  end
end
