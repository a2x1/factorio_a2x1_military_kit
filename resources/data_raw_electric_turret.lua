require "shared"

local settings_key_prefix = "a2x1_config_bits" .. "-" .. "data_raw_electric_turret" .. "-"

function __settings_startup__data_raw_electric_turret_range(data, order)
  return data:extend(
    {
      {
        type = "int-setting",
        name = settings_key_prefix .. "range",
        setting_type = "startup",
        default_value = 300,
        maximum_value = 100000,
        minimum_value = 1,
        localised_name = "Electric Turret Range",
        localised_description = "1% Smaller - 100% Default - 100000% Larger",
        order = tonumber(order .. "2")
      }
    }
  )
end

function __settings_startup__data_raw_electric_turret_damage(data, order)
  return data:extend(
    {
      {
        type = "int-setting",
        name = settings_key_prefix .. "damage",
        setting_type = "startup",
        default_value = 500,
        maximum_value = 100000,
        minimum_value = 1,
        localised_name = "Electric Turret Damage",
        localised_description = "1% Smaller - 100% Default - 100000% Larger",
        order = tonumber(order .. "1")
      }
    }
  )
end

function __data__data_raw_electric_turret(data, settings)
  for k, v in pairs(data.raw["electric-turret"]) do
    if v.attack_parameters then
      --

      -- range
      v.attack_parameters.range = (v.attack_parameters.range or 1) / 100 * (settings.startup[settings_key_prefix .. "range"].value or 100)

      if v.attack_parameters.ammo_type then
        if v.attack_parameters.ammo_type.action then
          if v.attack_parameters.ammo_type.action.action_delivery then
            if v.attack_parameters.ammo_type.action.action_delivery.target_effects then
              --
              local damage_laser

              for k1, v1 in pairs(v.attack_parameters.ammo_type.action.action_delivery.target_effects) do
                if v1.damage then
                  v1.damage.amount = (v1.damage.amount or 1) / 100 * (settings.startup[settings_key_prefix .. "damage"].value or 100)
                  damage_laser = v1.damage.amount
                end
              end

              table.insert(v.attack_parameters.ammo_type.action.action_delivery.target_effects, {type = "damage", damage = {amount = damage_laser, type = "laser"}})
            --
            end
          end
        end
      end

    --
    end
  end
end
