-----------------------------------
-- Area: Toraimarai Canal
--  Mob: Poroggo Excavator
-----------------------------------
mixins = { require('scripts/mixins/families/poroggo') }
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 625, 2, xi.regime.type.GROUNDS)
end

return entity
