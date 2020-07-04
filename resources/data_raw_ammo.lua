require "shared"

local settings_key_prefix = "a2x1_config_bits" .. "-" .. "data_raw_ammo" .. "-"

-- function __settings_startup__data_raw_ammo(data, order)
--   return data:extend(
--     {
--       {
--         type = "int-setting",
--         name = settings_key_prefix .. "damage",
--         setting_type = "startup",
--         default_value = 500,
--         maximum_value = 100000,
--         minimum_value = 1,
--         localised_name = "Gun Damage",
--         localised_description = "1% Smaller - 100% Default - 100000% Larger",
--         order = tonumber(order .. "1")
--       }
--     }
--   )
-- end

function __data__data_raw_ammo(data, settings)
  for k, v in pairs(data.raw["ammo"]) do
    --
    -- if type(v) == "table" and type(v.ammo_type) == "table" and type(v.ammo_type.action) == "table" then
    --   __shared__parse_data_action(v.ammo_type.action, (settings.startup[settings_key_prefix .. "damage"].value or 100))
    -- end

    if settings.startup["a2x1_config_bits" .. "-" .. "dual_damage"].value then
      if v.ammo_type and v.ammo_type.action then
        if v.ammo_type.action.action_delivery and v.ammo_type.action.action_delivery.target_effects then
          update_target_effects(v.ammo_type.action.action_delivery.target_effects)
        else
          --
          for k1, v1 in pairs(v.ammo_type.action) do
            if type(v1) == "table" and v1.action_delivery then
              for k2, v2 in pairs(v1.action_delivery) do
                if type(v2) == "table" and v2.target_effects then
                  --
                  update_target_effects(v2.target_effects)
                --
                end
              end
            end
          end
        end
      end
    end
  end
end

function update_target_effects(target_effects)
  local damage_type, damage_amount

  for k, v in pairs(target_effects) do
    if type(v) == "table" and v.damage then
      damage_type = v.damage.type
      damage_amount = v.damage.amount
    end
  end

  if damage_type == "physical" then
    table.insert(target_effects, {type = "damage", damage = {amount = damage_amount, type = "impact"}})
  end
end
