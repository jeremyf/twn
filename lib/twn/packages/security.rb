Twn::Packages.register(:Security) do
  to_uwp do
    sprintf(
      "{S%s%s%s-%s %s}",
      get!(:SecurityPlanetary).to_uwp_slug,
      get!(:SecurityOrbital).to_uwp_slug,
      get!(:SecuritySystem).to_uwp_slug,
      get!(:SecurityStance).to_uwp_slug,
      get!(:SecurityCodes).to_uwp_slug
    )
  end
end
