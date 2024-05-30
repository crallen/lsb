-----------------------------------
-- ID: 11276
-- Item: magna top +1
-- Teleport's user to Purgonorgo Isle
-----------------------------------
local itemObject = {}


itemObject.onItemCheck = function(target, item, param, caster)
    local result = 0
    if not target:hasVisitedZone(4) then
        result = 56
    end

    return result
end

itemObject.onItemUse = function(target)
    xi.teleport.to(target, xi.teleport.id.PURGONORGO)
end

return itemObject
