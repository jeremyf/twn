Twn::Packages.register(:Factions) do
  to_uwp do
    sprintf(
      "{%s}",
      get!(:Factions).to_uwp_slug,
    )
  end
end
