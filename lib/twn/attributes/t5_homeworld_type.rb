# I went back and forth on whether to apply a constraint around the
# GasGiant.
# From Traveller 5.10, Book 3, Page 24, Table 2B
Twn::Attributes.register(:T5HomeworldType) do
  table do
    row(roll: "Pl", description: "Planet")
    row(roll: "CG", description: "Close satellite of gas giant, tidally locked", constraints: [{ applies_to: :T5GasGiant, uwp_slug_range: (1..4) }])
    row(roll: "FG", description: "Far satellite of gas giant", constraints: [{ applies_to: :T5GasGiant, uwp_slug_range: (1..4) }])
    row(roll: "CP", description: "Close satellite of planet")
    row(roll: "FP", description: "Far satellite of planet")
  end

  roller do
    type = case roll("flux")
           when (-6..-4) then :far_satellite
           when -3 then :close_satellite
           when 2..6 then :planet
           end
    if type == :planet
      "Pl"
    else
      case roll("flux")
      when (-6..0)
        if type == :far_satellite
          "FG"
        else
          "CG"
        end
      when (1..6)
        if type == :far_satellite
          "FP"
        else
          "CP"
        end
      end
    end
  end
end
