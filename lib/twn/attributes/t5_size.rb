require 'twn/utility'
Twn::Attributes.register(:T5Size, package: :T5) do
  table do
    (0..15).each do |i|
      row(roll: i, description: (i == 0 ? "Asteroid Belt" : "#{i},000 miles diameter"), constraints: [{ applies_to: :Size, uwp_slug_range: [Twn::Utility.to_uwp_slug(i)] }])
    end
  end

  roller do
    result = roll("2d6") - 2
    if result == 10
      roll("1d6") + 9
    else
      result
    end
  end
end
