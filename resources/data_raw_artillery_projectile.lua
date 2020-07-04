require "shared"

local settings_key_prefix = "a2x1_config_bits" .. "-" .. "data_raw_artillery_projectile" .. "-"

function __settings_startup__data_raw_artillery_projectile(data, order)
  return data:extend(
    {
      {
        type = "int-setting",
        name = settings_key_prefix .. "damage",
        setting_type = "startup",
        default_value = 1000,
        maximum_value = 100000,
        minimum_value = 1,
        localised_name = "Artillery Projectile Damage",
        localised_description = "1% Smaller - 100% Default - 100000% Larger",
        order = tonumber(order .. "1")
      }
    }
  )
end

function __data__data_raw_artillery_projectile(data, settings)
  for k, v in pairs(data.raw["artillery-projectile"]) do
    --
    if type(v) == "table" and type(v.action) == "table" then
      __shared__parse_data_action(v.action, (settings.startup[settings_key_prefix .. "damage"].value or 100))
    end

    -- if v.action and v.action.action_delivery and v.action.action_delivery.target_effects then
    --   for k1, v1 in pairs(v.action.action_delivery.target_effects) do
    --     if v1.action and v1.action.action_delivery and v1.action.action_delivery.target_effects then
    --       for k2, v2 in pairs(v1.action.action_delivery.target_effects) do
    --         if v2.damage then
    --           v2.damage.amount = (v2.damage.amount or 1) / 100 * (settings.startup[settings_key_prefix .. "damage"].value or 100)
    --         -- v2.damage.amount = 8888
    --         end
    --       end
    --     end
    --   end
    -- end
    --
  end
end
