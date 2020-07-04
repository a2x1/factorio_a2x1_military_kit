require "shared"

local settings_key_prefix = "a2x1_config_bits" .. "-" .. "data_raw_ammo" .. "-"

function __settings_startup__data_raw_ammo(data, order)
  return data:extend(
    {
      {
        type = "int-setting",
        name = settings_key_prefix .. "damage",
        setting_type = "startup",
        default_value = 500,
        maximum_value = 100000,
        minimum_value = 1,
        localised_name = "Gun Damage",
        localised_description = "1% Smaller - 100% Default - 100000% Larger",
        order = tonumber(order .. "1")
      }
    }
  )
end

function __data__data_raw_ammo(data, settings)
  for k, v in pairs(data.raw["ammo"]) do
    if type(v) == "table" and type(v.ammo_type) == "table" and type(v.ammo_type.action) == "table" then
      __shared__parse_data_action(v.ammo_type.action, (settings.startup[settings_key_prefix .. "damage"].value or 100))
    end
  end
end
