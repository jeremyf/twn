Twn::Attributes.register(:PirateBase, package: :Core) do
  no = ""
  yes = "P"

  table do
    row(roll: no, description: "No pirate base")
    row(roll: yes, description: "Pirate base")
  end

  roller do
    case get!(:Starport).to_uwp_slug
    when "A", "X" then no
    when "B", "D", "E"
      roll("2d6") < 12 ? no : yes
    when "C"
      roll("2d6") < 10 ? no : yes
    end
  end
end
