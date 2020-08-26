require 'psych'
Twn::Attributes.register(:SwnWorldTags) do
  swn_tags = Psych.load(File.read(File.expand_path("../../../data/swn-tags.yml", __dir__)))

  table do
    swn_tags.each_with_index do |tag, i|
      row(roll: i+1, **tag)
    end
  end

  roller { (1..swn_tags.size).to_a.shuffle[0..1] }
end
