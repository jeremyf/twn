Twn::Attributes.register(:TravellersAidSociety, package: :Core) do
  no = ""
  yes = "T"
  table do
    row(roll: no, description: "No Traveller's Aid Society")
    row(roll: yes, description: "Traveller's Aid Society")
  end

  roller do
    case get!(:Starport).to_uwp_slug
    when "A"
      roll("2d6") < 4 ? no : yes
    when "B"
      roll("2d6") < 6 ? no : yes
    when "C"
      roll("2d6") < 10 ? no : yes
    when "D", "E", "X"
      no
    end
  end
end
