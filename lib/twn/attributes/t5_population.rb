require 'twn/utility'
Twn::Attributes.register(:T5Population, package: :T5) do
  table do
    (0..15).each do |i|
      row(roll: i, population: i == 0 ? "0" : "10^#{i}", constraints: [{ applies_to: :Population, uwp_slug_range: [Twn::Utility.to_uwp_slug(i)] }])
    end
  end
  roller do
    result = roll("2d6") - 2
    if result == 10
      roll("2d6") + 3
    else
      result
    end
  end
end
