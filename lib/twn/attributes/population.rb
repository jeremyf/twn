Twn::Attributes.register(:Population, package: :Core) do
  table do
    row(roll: 0, population: "None", range: "0")
    row(roll: 1, population: "Few", range: "1+")
    row(roll: 2, population: "Hundreds", range: "100+")
    row(roll: 3, population: "Thousands", range: "1,000+")
    row(roll: 4, population: "Tens of thousands", range: "10,000+")
    row(roll: 5, population: "Hundreds of thousands", range: "100,000+")
    row(roll: 6, population: "Millions", range: "1,000,000+")
    row(roll: 7, population: "Tens of millions", range: "10,000,000+")
    row(roll: 8, population: "Hundreds of millions", range: "100,000,000+")
    row(roll: 9, population: "Billions", range: "1,000,000,000+")
    row(roll: 10, population: "Tens of Billions", range: "10,000,000,000+")
    row(roll: 11, population: "Hundreds of Billions", range: "100,000,000+")
    row(roll: 12, population: "Trillions", range: "1,000,000,000+")
  end

  roller { roll("2d6", -2) }
end
