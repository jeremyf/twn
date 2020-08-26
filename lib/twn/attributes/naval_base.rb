Twn::Attributes.register(:NavalBase) do
  no = ""
  yes = "N"

  table do
    row(roll: no, description: "No naval base")
    row(roll: yes, description: "Naval base")
  end

  roller do
    case get!(:Starport).to_uwp_slug
    when "A"
      roll("2d6") < 8 ? no : yes
    when "B"
      roll("2d6") < 8 ? no : yes
    when "C", "D", "E", "X"
      no
    end
  end
end
