-----------------------------------
-- Serpentarius Module Constants
-----------------------------------

xi = xi or {}
xi.serpentarius = xi.serpentarius or {}

-----------------------------------
-- Buff Command Settings
-----------------------------------
xi.serpentarius.buff =
{
    -- XP/CP bonus effect settings
    xpBonus =
    {
        power    = 500,   -- 500% bonus XP/CP
        subpower = 30000, -- Max bonus XP/CP before effect reapplies (client cap: 30000)
    },

    -- Status effects for players below level 99
    lowLevelEffects =
    {
        { effect = xi.effect.REGEN,   power = 20 },
        { effect = xi.effect.REFRESH, power = 20 },
        { effect = xi.effect.REGAIN,  power = 15 },
    },

    -- Status effects for players at level 99
    maxLevelEffects =
    {
        { effect = xi.effect.REGAIN, power = 15 },
    },

    -- Level threshold for switching buff sets
    maxLevelThreshold = 99,
}
