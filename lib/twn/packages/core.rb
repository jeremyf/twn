Twn::Packages.register(:Core) do
  to_uwp do
    sprintf(
      "%s%s%s%s%s%s%s-%-2d %7s  %s %2s",
      get!(:Starport).to_uwp_slug,
      get!(:Size).to_uwp_slug,
      get!(:Atmosphere).to_uwp_slug,
      get!(:Hydrographic).to_uwp_slug,
      get!(:Population).to_uwp_slug,
      get!(:Government).to_uwp_slug,
      get!(:LawLevel).to_uwp_slug,
      get!(:TechLevel).roll,
      [:NavalBase, :ScoutBase, :ResearchBase, :TravellersAidSociety, :ImperialConsulate, :PirateBase, :GasGiant].map do |base|
        get!(base).to_uwp_slug
      end.join.strip,
      get!(:TradeCodes).to_uwp_slug,
      get!(:TravelCode).to_uwp_slug
    )
  end
end
