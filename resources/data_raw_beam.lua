require "shared"

function __data__data_raw_beam(data, settings)
  for k, v in pairs(data.raw["beam"]) do
    --

    if settings.startup["a2x1_config_bits" .. "-" .. "dual_damage"].value then
      if v.action then
        if v.action.action_delivery then
          if v.action.action_delivery.target_effects then
            --
            local damage_amount
            local damage_type

            for k1, v1 in pairs(v.action.action_delivery.target_effects) do
              if type(v1) == "table" and v1.damage then
                damage_amount = v1.damage.amount
                damage_type = v1.damage.type
              end
            end

            if damage_type == "electric" then
              table.insert(v.action.action_delivery.target_effects, {type = "damage", damage = {amount = damage_amount, type = "fire"}})
            end
            if damage_type == "laser" then
              table.insert(v.action.action_delivery.target_effects, {type = "damage", damage = {amount = damage_amount, type = "fire"}})
            end
          --
          end
        end
      end
    end

    --
  end
end
