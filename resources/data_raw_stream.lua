require "shared"

function __data__data_raw_stream(data, settings)
  for k, v in pairs(data.raw["stream"]) do
    --
    if settings.startup["a2x1_config_bits" .. "-" .. "dual_damage"].value then
      if v.action then
        for k1, v1 in pairs(v.action) do
          if type(v1) == "table" and v1.action_delivery and v1.action_delivery.target_effects then
            --
            local damage_amount
            local damage_type

            for k2, v2 in pairs(v1.action_delivery.target_effects) do
              if type(v2) == "table" and v2.damage then
                damage_amount = v2.damage.amount
                damage_type = v2.damage.type
              end

              if damage_type == "fire" then
                table.insert(v1.action_delivery.target_effects, {type = "damage", damage = {amount = damage_amount, type = "acid"}})
              end
            end
          end
          --
        end
      end
    end
    --
  end
end
