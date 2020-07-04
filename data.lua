require "resources/data_raw_artillery_projectile"
require "resources/data_raw_projectile"
require "resources/data_raw_ammo_turret"
require "resources/data_raw_ammo"
require "resources/data_raw_electric_turret"

__data__data_raw_artillery_projectile(data, settings)
__data__data_raw_projectile(data, settings)
__data__data_raw_ammo_turret(data, settings)
__data__data_raw_ammo(data, settings)

if mods["scattergun_turret"] then
__data__data_raw_electric_turret(data, settings)
end
