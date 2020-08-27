require 'twn/config'
require 'psych'
Twn::Attributes.register(:SwnWorldTags, package: :SWN) do
  swn_tags = Psych.load(File.read(File.expand_path("../../../data/swn-tags.yml", __dir__)))

  table do
    swn_tags.each_with_index do |tag, i|
      # A bit of massaging the data; If the configured tech level is
      # less than the tech levels written in the swn-data, then I get
      # several errors on large test runs.  If the configured tech
      # level is larger, then the constraints need to be updated to
      # reflect that.
      #
      # All of this is to say that I don't have a "15+" evaluation for
      # constraint testing.
      if tag.key?(:constraints)
        tag[:constraints].each do |constraint|
          if constraint[:applies_to].to_s == "TechLevel"
            if constraint[:uwp_slug_range].include?(15)
              constraint[:uwp_slug_range] = (constraint[:uwp_slug_range] + (15..Twn::Config.max_tech_level).to_a).uniq
            end
          end
        end
      end
      row(roll: i+1, **tag)
    end
  end

  roller { (1..swn_tags.size).to_a.shuffle[0..1] }
end
