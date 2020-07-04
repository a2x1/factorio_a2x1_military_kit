require "resources/data_raw_projectile"
require "resources/data_raw_artillery_projectile"

require "resources/data_raw_ammo_turret"
require "resources/data_raw_fluid_turret"
require "resources/data_raw_electric_turret"

data:extend(
  {
    {
      type = "bool-setting",
      name = "a2x1_config_bits" .. "-" .. "dual_damage",
      setting_type = "startup",
      default_value = true,
      localised_name = "Enable Dual Damage Types",
      localised_description = "Adds Second Damage Type to all Damage Sources",
      order = "100"
    }
  }
)

__settings_startup__data_raw_projectile(data, 220)
__settings_startup__data_raw_artillery_projectile(data, 230)

__settings_startup__data_raw_ammo_turret(data, 110)
__settings_startup__data_raw_fluid_turret(data, 120)
__settings_startup__data_raw_electric_turret(data, 130)
