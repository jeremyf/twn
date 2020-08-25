require 'twn/attributes'
Twn::Attributes.register(:ImperialConsulate) do
  no = ""
  yes = "C"

  table do
    add_row(roll: no, description: "No Imperial Consulate")
    add_row(roll: yes, description: "Imperial Consulate")
  end

  roller do
    case get!(:Starport).to_uwp_slug
    when "A"
      roll("2d6") < 6 ? no : yes
    when "B"
      roll("2d6") < 8 ? no : yes
    when "C"
      roll("2d6") < 10 ? no : yes
    when "D", "E", "X"
      no
    end
  end
end
