function __shared__parse_data_action(data_action, damage)
  if type(data_action) == "table" then
    if type(data_action.action_delivery) == "table" and data_action.action_delivery.target_effects then
      __shared__parse_data_action_target_effects(data_action.action_delivery.target_effects, damage)
    else
      for k1, v1 in pairs(data_action) do
        if type(v1) == "table" and v1.action_delivery then
          if type(v1.action_delivery) == "table" and v1.action_delivery.target_effects then
            __shared__parse_data_action_target_effects(v1.action_delivery.target_effects, damage)
          else
            for k2, v2 in pairs(v1.action_delivery) do
              if type(v2) == "table" and v2.target_effects then
                __shared__parse_data_action_target_effects(v2.target_effects, damage)
              end -- if type(v2) == "table" and v2.target_effects
            end -- for k2, v2 in pairs(v1.action_delivery)
          end -- if type(v1.action_delivery) == "table" and v1.action_delivery.target_effects
        end -- if type(v1) == "table" and v1.action_delivery
      end -- for k1, v1 in pairs(data_action)
    end -- if type(data_action.action_delivery) == "table" and data_action.action_delivery.target_effects
  end -- type(data_action) == "table"
end

function __shared__parse_data_action_target_effects(target_effects, damage)
  if type(target_effects) == "table" then
    for k, v in pairs(target_effects) do
      --
      if type(v) == "table" and v.damage then
        v.damage.amount = (v.damage.amount or 1) / 100 * damage
      elseif type(v) == "table" and v.action and v.action.action_delivery and v.action.action_delivery.target_effects then
        __shared__parse_data_action_target_effects(v.action.action_delivery.target_effects, damage)
      end
      --
    end -- for k, v in pairs(target_effects)
  end -- type(target_effects) == "table"
end
