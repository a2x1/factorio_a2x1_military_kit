local settings_key_prefix = "a2x1_config_bits" .. "-" .. "data_raw_electric_turret" .. "-"

function __settings_startup__data_raw_electric_turret(data, order)
  return data:extend(
    {
      {
        type = "int-setting",
        name = settings_key_prefix .. "range",
        setting_type = "startup",
        default_value = 200,
        maximum_value = 100000,
        minimum_value = 1,
        localised_name = "Electric Turret Range",
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
        localised_name = "Electric Turret Damage Modifier",
        localised_description = "1% Smaller - 100% Default - 100000% Larger",
        order = tonumber(order .. "3")
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
      v.prepare_range = v.attack_parameters.range + 1

      if v.attack_parameters.ammo_type then
        if v.attack_parameters.ammo_type.action then
          if v.attack_parameters.ammo_type.action.action_delivery then
            if v.attack_parameters.ammo_type.action.action_delivery.max_length then
              v.attack_parameters.ammo_type.action.action_delivery.max_length = v.attack_parameters.range
            end
          end
        end
      end

      -- damage_modifier
      v.attack_parameters.damage_modifier = (v.attack_parameters.damage_modifier or 1) / 100 * (settings.startup[settings_key_prefix .. "damage_modifier"].value or 100)
      -- v.attack_parameters.damage_modifier = 100.23
      -- error(v.attack_parameters.damage_modifier)

      if settings.startup["a2x1_config_bits" .. "-" .. "dual_damage"].value then
        if v.attack_parameters.ammo_type then
          if v.attack_parameters.ammo_type.action then
            if v.attack_parameters.ammo_type.action.action_delivery then
              if v.attack_parameters.ammo_type.action.action_delivery.target_effects then
                --
                local extra_damage_amount
                local extra_damage_type = "laser"

                for k1, v1 in pairs(v.attack_parameters.ammo_type.action.action_delivery.target_effects) do
                  if type(v1) == "table" and v1.damage then
                    -- v1.damage.amount = (v1.damage.amount or 1) + (settings.startup[settings_key_prefix .. "damage_bonus"].value or 0)
                    extra_damage_amount = v1.damage.amount
                    extra_damage_type = v1.damage.type
                  end
                end

                if extra_damage_type == "laser" then
                  extra_damage_type = "fire"
                end
                table.insert(v.attack_parameters.ammo_type.action.action_delivery.target_effects, {type = "damage", damage = {amount = extra_damage_amount, type = extra_damage_type}})
              --
              end
            end
          end
        end
      end

    --
    end
  end
end
