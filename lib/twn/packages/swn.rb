Twn::Packages.register(:SWN) do
  to_uwp do
    sprintf(
      "{%s}",
      get!(:SwnWorldTags).to_uwp_slug
    )
  end
end
