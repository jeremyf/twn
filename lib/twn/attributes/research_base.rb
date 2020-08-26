Twn::Attributes.register(:ResearchBase) do
  no = ""
  yes = "R"

  table do
    row(roll: no, description: "No research base")
    row(roll: yes, description: "Research base")
  end

  roller do
    case get!(:Starport).to_uwp_slug
    when "B", "C"
      roll("2d6") < 10 ? no : yes
    when "A"
      roll("2d6") < 8 ? no : yes
    when "D", "E", "X"
      no
    end
  end
end
