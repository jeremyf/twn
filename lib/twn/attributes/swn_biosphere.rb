Twn::Attributes.register(:SwnBiosphere, package: :SWN) do
  table do
    row(roll: "Re", type: "Remnant")
    row(roll: "Mi", type: "Microbial")
    row(roll: "No", type: "No")
    row(roll: "HM", type: "Human-miscible")
    row(roll: "Im", type: "Immiscible")
    row(roll: "Hy", type: "Hybrid")
    row(roll: "En", type: "Engineered")
  end

  roller do
    case roll("2d6")
    when 2 then "Re"
    when 3 then "Mi"
    when 4,5 then "No"
    when 6,7,8 then "HM"
    when 9,10 then "Im"
    when 11 then "Hy"
    when 12 then "En"
    end
  end
end
