# Ag  Agricultural
# As  Asteroid
# Ba  Barren
# De  Desert
# Fl  Fluid Oceans
# Ga  Garden
# Hi  High Population
# Ht  High Technology
# IC  Ice-Capped
# In  Industrial
# Lo  Low Population
# Lt  Low Technolgy
# Na  Non-Agricultural
# Ni  Non-Industrial
# Po  Poor
# Ri  Rich
# Va  Vacuum
# Wa  Water world

Twn::TradeGoods.table do
  roll(11, name: "Common Electronics") do
    availability(:all) ; tons("2d6", x: 10) ; base_price(20_000) ; purchase(In: 2, Ht: 3, Ri: 1) ; sale(Ni: 2, Lt: 1, Po: 1)
  end
  roll(12, name: "Common Industrial Goods") do
    availability(:all) ; tons("2d6", x: 10); base_price(10_000); purchase(Na: 2, In: 5); sale(Ni: 3, Ag: 2)
  end
end
