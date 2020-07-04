local settings_key_prefix = "a2x1_config_bits" .. "-" .. "data_raw_fluid_turret" .. "-"

function __settings_startup__data_raw_fluid_turret(data, order)
  return data:extend(
    {
      {
        type = "int-setting",
        name = settings_key_prefix .. "range",
        setting_type = "startup",
        default_value = 200,
        maximum_value = 100000,
        minimum_value = 1,
        localised_name = "Flamethrower Turret Range",
        localised_description = "1% Smaller - 100% Default - 100000% Larger",
        order = tonumber(order .. "1")
      },
      {
        type = "int-setting",
        name = settings_key_prefix .. "damage_modifier",
        setting_type = "startup",
        default_value = 10000,
        maximum_value = 100000,
        minimum_value = 1,
        localised_name = "Flamethrower Turret Damage Modifier",
        localised_description = "1% Smaller - 100% Default - 100000% Larger",
        order = tonumber(order .. "3")
      }
    }
  )
end

function __data__data_raw_fluid_turret(data, settings)
  for k, v in pairs(data.raw["fluid-turret"]) do
    if v.attack_parameters then
      --

      -- range
      v.attack_parameters.range = (v.attack_parameters.range or 1) / 100 * (settings.startup[settings_key_prefix .. "range"].value or 100)
      v.prepare_range = v.attack_parameters.range + 1

      -- damage_modifier
      v.attack_parameters.damage_modifier = (v.attack_parameters.damage_modifier or 1) / 100 * (settings.startup[settings_key_prefix .. "damage_modifier"].value or 100)

    --
    end
  end
end
