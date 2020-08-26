Twn::Attributes.register(:ScoutBase) do
  no = ""
  yes = "S"

  table do
    row(roll: no, description: "No scout base")
    row(roll: yes, description: "Scout base")
  end

  roller do
    case get!(:Starport).to_uwp_slug
    when "A"
      roll("2d6") < 10 ? no : yes
    when "B", "C"
      roll("2d6") < 8 ? no : yes
    when "D"
      roll("2d6") < 7 ? no : yes
    when "E", "X"
      no
    end
  end
end
