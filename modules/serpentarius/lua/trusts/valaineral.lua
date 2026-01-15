-----------------------------------
-- Trust: Valaineral
-----------------------------------
require('modules/module_utils')
require('scripts/globals/trust')
-----------------------------------
local m = Module:new('Valaineral')
local trustName = 'valaineral'

m:addOverride(string.format('xi.actions.spells.trust.%s.onMobSpawn', trustName), function(mob)
    xi.trust.message(mob, xi.trust.messageOffset.SPAWN)

    mob:setMobMod(xi.mobMod.CAN_SHIELD_BLOCK, 1)
    
    mob:addMod(xi.mod.CURE_POTENCY, 50)
    mob.addMod(xi.mod.ENMITY, 50)
    mob:addMod(xi.mod.SPELLINTERRUPT, 35)
    mob:addMod(xi.mod.REFRESH, 3)
    mob:addMod(xi.mod.SHIELDBLOCKRATE, 45)
    mob:addMod(xi.mod.DMG, -800)
    mob:addMod(xi.mod.HPP, 10)
    mob:addMod(xi.mod.MPP, 20)

    -- Use Uriel Blade as ability when master has enmity
    mob:addGambit(ai.t.TARGET, { ai.c.MASTER_HAS_ENMITY, -1 }, { ai.r.WS, ai.s.SPECIFIC, xi.ws.URIEL_BLADE, xi.wsFlag.FREE_1000TP })

    mob:addGambit(ai.t.SELF, { ai.c.NOT_HAS_TOP_ENMITY, 0 }, { ai.r.JA, ai.s.SPECIFIC, xi.ja.PROVOKE })
    mob:addGambit(ai.t.TARGET, { ai.c.NOT_STATUS, xi.effect.FLASH }, { ai.r.MA, ai.s.SPECIFIC, xi.magic.spell.FLASH })
    mob:addGambit(ai.t.SELF, { ai.c.NOT_STATUS, xi.effect.SENTINEL }, { ai.r.JA, ai.s.SPECIFIC, xi.ja.SENTINEL })
    mob:addGambit(ai.t.PARTY, { ai.c.HPP_LT, 50 }, { ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.CURE })
end)