local settings_key_prefix = "a2x1_config_bits" .. "-" .. "data_raw_ammo_turret" .. "-"

function __settings_startup__data_raw_ammo_turret(data, order)
  return data:extend(
    {
      {
        type = "int-setting",
        name = settings_key_prefix .. "range",
        setting_type = "startup",
        default_value = 300,
        maximum_value = 100000,
        minimum_value = 1,
        localised_name = "Gun Turret Range",
        localised_description = "1% Smaller - 100% Default - 100000% Larger",
        order = tonumber(order .. "2")
      }
    }
  )
end

function __data__data_raw_ammo_turret(data, settings)
  for k, v in pairs(data.raw["ammo-turret"]) do
    --

    -- attack_parameters_range
    v.attack_parameters.range = (v.attack_parameters.range or 1) / 100 * (settings.startup[settings_key_prefix .. "range"].value or 100)

    --
  end
end
