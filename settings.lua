require "resources/data_raw_artillery_projectile"
require "resources/data_raw_projectile"
require "resources/data_raw_ammo_turret"
require "resources/data_raw_ammo"
require "resources/data_raw_electric_turret"


__settings_startup__data_raw_ammo(data, 210)
__settings_startup__data_raw_projectile(data, 220)
__settings_startup__data_raw_artillery_projectile(data, 230)

if mods["scattergun_turret"] then
__settings_startup__data_raw_electric_turret_damage(data, 240)
end


__settings_startup__data_raw_ammo_turret(data, 310)

if mods["scattergun_turret"] then
__settings_startup__data_raw_electric_turret_range(data, 320)
end
