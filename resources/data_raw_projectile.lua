require "shared"

local settings_key_prefix = "a2x1_config_bits" .. "-" .. "data_raw_projectile" .. "-"

function __settings_startup__data_raw_projectile(data, order)
  return data:extend(
    {
      {
        type = "int-setting",
        name = settings_key_prefix .. "damage",
        setting_type = "startup",
        default_value = 500,
        maximum_value = 100000,
        minimum_value = 1,
        localised_name = "Projectile Damage",
        localised_description = "1% Smaller - 100% Default - 100000% Larger",
        order = tonumber(order .. "1")
      }
    }
  )
end

function __data__data_raw_projectile(data, settings)
  for k, v in pairs(data.raw["projectile"]) do
    --
    if type(v) == "table" and type(v.action) == "table" then
      __shared__parse_data_action(v.action, (settings.startup[settings_key_prefix .. "damage"].value or 100))
    end

    if type(v) == "table" and type(v.final_action) == "table" then
      __shared__parse_data_action(v.final_action, (settings.startup[settings_key_prefix .. "damage"].value or 100))
    end

    if type(v) == "table" and v.piercing_damage then
      v.piercing_damage = (piercing_damage or 1) / 100 * (settings.startup[settings_key_prefix .. "damage"].value or 100)
    end
    --
  end
end
