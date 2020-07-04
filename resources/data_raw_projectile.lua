require "shared"

local settings_key_prefix = "a2x1_config_bits" .. "-" .. "data_raw_projectile" .. "-"

function __settings_startup__data_raw_projectile(data, order)
  return data:extend(
    {
      {
        type = "int-setting",
        name = settings_key_prefix .. "damage",
        setting_type = "startup",
        default_value = 1000,
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

    if settings.startup["a2x1_config_bits" .. "-" .. "dual_damage"].value then
      if v.action then
        if v.action.action_delivery and v.action.action_delivery.target_effects then
          update_target_effects(v.action.action_delivery.target_effects)
        else
          for k1, v1 in pairs(v.action) do
            if type(v1) == "table" and v1.action_delivery and v1.action_delivery.target_effects then
              update_target_effects(v1.action_delivery.target_effects)
            end
          end
        end
      end
    end

    --
  end
end

function update_target_effects(target_effects)
  local damage_amount, damage_type
  local count = 0

  for k, v in pairs(target_effects) do
    if type(v) == "table" and v.damage then
      damage_amount = v.damage.amount
      damage_type = v.damage.type
      count = count + 1
    end
  end

  if count == 1 then
    if damage_type == "explosion" then
      table.insert(target_effects, {type = "damage", damage = {amount = damage_amount, type = "physical"}})
    end
    if damage_type == "physical" then
      table.insert(target_effects, {type = "damage", damage = {amount = damage_amount, type = "impact"}})
    end
  end
end
