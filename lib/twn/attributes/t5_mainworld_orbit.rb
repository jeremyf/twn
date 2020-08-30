require 'forwardable'
require 'twn/utility'
# Extrapolated from T5.10, Book 3, p24, table 2B
Twn::Attributes.register(:T5HomeworldOrbit, package: :T5) do
  table do
    row(roll: -2)
    row(roll: -1)
    row(roll: 0)
    row(roll: 1)
    row(roll: 2)
  end


  roller do
    spectral = get!(:T5HomestarSpectral).to_uwp_slug
    homestar_dm = 0
    homestar_dm = 2 if spectral == "M"
    homestar_dm = -2 if spectral == "O"
    homestar_dm = -2 if spectral == "OB"
    homestar_dm = -2 if spectral == "B"
    case roll("flux") + homestar_dm
    when -7, -6 then -2
    when (-5..-3) then -1
    when (-2..2) then 0
    when (3..5) then 1
    when (6..7) then 2
    end
  end
end
