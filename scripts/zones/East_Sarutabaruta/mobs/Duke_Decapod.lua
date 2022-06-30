-----------------------------------
-- Area: East Sarutabaruta (116)
--   NM: Duke Decapod
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobFight = function(mob, target)
    local castTime = mob:getLocalVar("dukeWater")

    if os.time() > castTime then
        mob:castSpell(169)
        mob:setLocalVar("dukeWater", os.time() + 10)
    end
end

entity.onMobDeath = function(mob, player, isKiller)
    xi.hunts.checkHunt(mob, player, 255)
end

entity.onMobDespawn = function(mob)
    mob:setRespawnTime(math.random(3600, 4200))
end

return entity
