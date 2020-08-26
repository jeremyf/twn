Twn::Attributes.register(:Size) do
  table do
    row(roll: 0, size: 800, surface_gravity: 0, example: "Asteroid, orbital complex")
    row(roll: 1, size: 1600, surface_gravity: 0.05, example: "")
    row(roll: 2, size: 3200, surface_gravity: 0.15, example: "Triton, Luna, Europa")
    row(roll: 3, size: 4800, surface_gravity: 0.25, example: "Mercury, Ganymede")
    row(roll: 4, size: 6400, surface_gravity: 0.35, example: "Mars")
    row(roll: 5, size: 8000, surface_gravity: 0.45, example: "")
    row(roll: 6, size: 9600, surface_gravity: 0.7, example: "")
    row(roll: 7, size: 11_200, surface_gravity: 0.9, example: "")
    row(roll: 8, size: 12_800, surface_gravity: 1, example: "Earth")
    row(roll: 9, size: 14_400, surface_gravity: 1.25, example: "")
    row(roll: 10, size: 16_000, surface_gravity: 1.4, example: "")
  end

  roller { roll("2d6", -2) }
end
