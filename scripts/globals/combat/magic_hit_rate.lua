-----------------------------------
-- Global file for magic based skills magic hit rate.
-----------------------------------
require("scripts/globals/combat/element_tables")
require("scripts/globals/combat/level_correction")
-----------------------------------
xi = xi or {}
xi.combat = xi.combat or {}
xi.combat.magicHitRate = xi.combat.magicHitRate or {}
-----------------------------------
-- Actor Magic Accuracy
xi.combat.magicHitRate.calculateActorMagicAccuracy = function(actor, target, spellGroup, skillType, spellElement, statUsed, bonusMacc)
    local actorJob     = actor:getMainJob()
    local actorWeather = actor:getWeather()
    local statDiff     = actor:getStat(statUsed) - target:getStat(statUsed)
    local magicAcc     = actor:getMod(xi.mod.MACC) + actor:getILvlMacc(xi.slot.MAIN)

    -- Get the base magicAcc (just skill + skill mod (79 + skillID = ModID))
    if skillType ~= 0 then
        magicAcc = magicAcc + actor:getSkillLevel(skillType)
    else
        -- For mob skills / additional effects which don't have a skill.
        magicAcc = magicAcc + utils.getSkillLvl(1, actor:getMainLvl())
    end

    -- Add action bonus magic accuracy.
    magicAcc = magicAcc + bonusMacc

    -- Add acc for elemental affinity accuracy and element specific accuracy
    if spellElement ~= xi.magic.ele.NONE then
        local elementBonus  = actor:getMod(xi.combat.element.elementalMagicAcc[spellElement])
        local affinityBonus = actor:getMod(xi.combat.element.strongAffinityAcc[spellElement]) * 10

        magicAcc = magicAcc + elementBonus + affinityBonus
    end

    -- Get dStat Magic Accuracy.
    -- dStat is calculated the same for all types of Magic
    -- https://wiki.ffo.jp/html/3500.html
    -- https://wiki.ffo.jp/html/19417.html (Difference in INT validation)
    local dStatMacc = 0

    if statDiff <= -31 then
        dStatMacc = -20 + (statDiff + 30) / 4
    elseif statDiff <= -11 then
        dStatMacc = -10 + (statDiff + 10) / 2
    elseif statDiff < 11 then -- Between -11 and 11
        dStatMacc = statDiff
    elseif statDiff >= 31 then
        dStatMacc = 20 + (statDiff - 30) / 4
    elseif statDiff >= 11 then
        dStatMacc = 10 + (statDiff - 10) / 2
    end

    magicAcc = magicAcc + utils.clamp(dStatMacc, -30, 30)

    -----------------------------------
    -- magicAcc from status effects.
    -----------------------------------
    -- Altruism
    if
        actor:hasStatusEffect(xi.effect.ALTRUISM) and
        spellGroup == xi.magic.spellGroup.WHITE
    then
        magicAcc = magicAcc + actor:getStatusEffect(xi.effect.ALTRUISM):getPower()
    end

    -- Focalization
    if
        actor:hasStatusEffect(xi.effect.FOCALIZATION) and
        spellGroup == xi.magic.spellGroup.BLACK
    then
        magicAcc = magicAcc + actor:getStatusEffect(xi.effect.FOCALIZATION):getPower()
    end

    --Add acc for klimaform
    if
        actor:hasStatusEffect(xi.effect.KLIMAFORM) and
        spellElement > 0 and
        (actorWeather == xi.magic.singleWeatherStrong[spellElement] or actorWeather == xi.magic.doubleWeatherStrong[spellElement])
    then
        magicAcc = magicAcc + 15
    end

    -- Apply Divine Emblem to Banish and Holy families
    if
        actor:hasStatusEffect(xi.effect.DIVINE_EMBLEM) and
        actorJob == xi.job.PLD and
        skillType == xi.skill.DIVINE_MAGIC
    then
        magicAcc = magicAcc + 100 -- TODO: Confirm this value in retail
    end

    -- Elemental seal
    if
        actor:hasStatusEffect(xi.effect.ELEMENTAL_SEAL) and
        skillType ~= xi.skill.DARK_MAGIC and
        skillType ~= xi.skill.DIVINE_MAGIC and
        spellElement > 0
    then
        magicAcc = magicAcc + 256
    end

    -- Dark Seal
    if
        actor:hasStatusEffect(xi.effect.DARK_SEAL) and
        skillType == xi.skill.DARK_MAGIC
    then
        magicAcc = magicAcc + 256
    end

    -----------------------------------
    -- magicAcc from Job Points.
    -----------------------------------
    switch (actorJob) : caseof
    {
        [xi.job.WHM] = function()
            magicAcc = magicAcc + actor:getJobPointLevel(xi.jp.WHM_MAGIC_ACC_BONUS)
        end,

        [xi.job.BLM] = function()
            magicAcc = magicAcc + actor:getJobPointLevel(xi.jp.BLM_MAGIC_ACC_BONUS)
        end,

        [xi.job.RDM] = function()
            -- RDM Job Point: During saboteur, Enfeebling MACC +2
            if
                skillType == xi.skill.ENFEEBLING_MAGIC and
                actor:hasStatusEffect(xi.effect.SABOTEUR)
            then
                magicAcc = magicAcc + (actor:getJobPointLevel(xi.jp.SABOTEUR_EFFECT)) * 2
            end

            -- RDM Job Point: Magic Accuracy Bonus, All MACC + 1
            magicAcc = magicAcc + actor:getJobPointLevel(xi.jp.RDM_MAGIC_ACC_BONUS)
        end,

        [xi.job.NIN] = function()
            if skillType == xi.skill.NINJUTSU then
                magicAcc = magicAcc + actor:getJobPointLevel(xi.jp.NINJITSU_ACC_BONUS)
            end
        end,

        [xi.job.SCH] = function()
            if
                (spellGroup == xi.magic.spellGroup.WHITE and actor:hasStatusEffect(xi.effect.PARSIMONY)) or
                (spellGroup == xi.magic.spellGroup.BLACK and actor:hasStatusEffect(xi.effect.PENURY))
            then
                magicAcc = magicAcc + actor:getJobPointLevel(xi.jp.STRATEGEM_EFFECT_I)
            end
        end,
    }

    -----------------------------------
    -- magicAcc from Merits.
    -----------------------------------
    switch (actorJob) : caseof
    {
        [xi.job.BLM] = function()
            if skillType == xi.skill.ELEMENTAL_MAGIC then
                magicAcc = magicAcc + actor:getMerit(xi.merit.ELEMENTAL_MAGIC_ACCURACY)
            end
        end,

        [xi.job.RDM] = function()
            -- Category 1
            if
                spellElement >= xi.magic.element.FIRE and
                spellElement <= xi.magic.element.WATER
            then
                magicAcc = magicAcc + actor:getMerit(xi.combat.element.rdmMerit[spellElement])
            end

            -- Category 2
            magicAcc = magicAcc + actor:getMerit(xi.merit.MAGIC_ACCURACY)
        end,

        [xi.job.NIN] = function()
            if skillType == xi.skill.NINJUTSU then
                magicAcc = magicAcc + actor:getMerit(xi.merit.NIN_MAGIC_ACCURACY)
            end
        end,

        [xi.job.BLU] = function()
            if skillType == xi.skill.BLUE_MAGIC then
                magicAcc = magicAcc + actor:getMerit(xi.merit.MAGICAL_ACCURACY)
            end
        end,
    }

    -----------------------------------
    -- magicAcc from Food.
    -----------------------------------
    local maccFood = magicAcc * (actor:getMod(xi.mod.FOOD_MACCP) / 100)
    magicAcc = magicAcc + utils.clamp(maccFood, 0, actor:getMod(xi.mod.FOOD_MACC_CAP))

    -----------------------------------
    -- magicAcc from Magic Burst
    -----------------------------------
    local _, skillchainCount = FormMagicBurst(spellElement, target)

    if skillchainCount > 0 then
        magicAcc = magicAcc + 100
    end

    -----------------------------------
    -- magicAcc from Weather
    -----------------------------------
    local weather = actor:getWeather()

    -- Calculate Weather bonus
    if
        math.random(1, 100) <= 33 or
        actor:getMod(xi.combat.element.elementalObi[spellElement]) >= 1
    then
        -- Strong weathers.
        if weather == xi.combat.element.strongSingleWeather[spellElement] then
            magicAcc = magicAcc + 5
            if actor:getMod(xi.mod.IRIDESCENCE) >= 1 then
                magicAcc = magicAcc + 5
            end
        elseif weather == xi.combat.element.strongDoubleWeather[spellElement] then
            magicAcc = magicAcc + 10
            if actor:getMod(xi.mod.IRIDESCENCE) >= 1 then
                magicAcc = magicAcc + 5
            end

        -- Weak weathers.
        elseif weather == xi.combat.element.weakSingleWeather[spellElement] then
            magicAcc = magicAcc - 5
            if actor:getMod(xi.mod.IRIDESCENCE) >= 1 then
                magicAcc = magicAcc - 5
            end
        elseif weather == xi.combat.element.weakDoubleWeather[spellElement] then
            magicAcc = magicAcc - 10
            if actor:getMod(xi.mod.IRIDESCENCE) >= 1 then
                magicAcc = magicAcc - 5
            end
        end
    end

    -----------------------------------
    -- magicAcc from Day
    -----------------------------------
    local dayElement = VanadielDayElement()

    if
        math.random(1, 100) <= 33 or
        actor:getMod(xi.combat.element.elementalObi[spellElement]) >= 1
    then
        -- Strong day.
        if dayElement == spellElement then
            magicAcc = magicAcc + 5

        -- Weak day.
        elseif dayElement == xi.combat.element.weakDay[spellElement] then
            magicAcc = magicAcc - 5
        end
    end

    return magicAcc
end

-- Target Magic Evasion
xi.combat.magicHitRate.calculateTargetMagicEvasion = function(actor, target, spellElement, isEnfeeble, mEvaMod, rankModifier)
    local magicEva   = target:getMod(xi.mod.MEVA) -- Base MACC.
    local resistRank = 0 -- Elemental specific Resistance rank. Acts as multiplier to base MACC.
    local resMod     = 0 -- Elemental specific magic evasion. Acts as a additive bonus to base MACC after affected by resistance rank.
    local levelDiff  = target:getMainLvl() - actor:getMainLvl()

    -- Elemental magic evasion.
    if spellElement ~= xi.magic.ele.NONE then
        -- Mod set in database for mobs. Base 0 means not resistant nor weak. Bar-element spells included here.
        resMod     = target:getMod(xi.combat.element.elementalMagicEva[spellElement])
        resistRank = target:getMod(xi.combat.element.resistRankMod[spellElement])

        if resistRank > 4 then
            resistRank = utils.clamp(resistRank - rankModifier, 4, 11)
        end

        magicEva = magicEva * (1 + (resistRank * 0.075))
        magicEva = magicEva + resMod
    end

    -- Magic evasion against specific status effects.
    if isEnfeeble then
        magicEva = magicEva + target:getMod(mEvaMod) + target:getMod(xi.mod.STATUS_MEVA)
    end

    -- Level correction. Target gets a bonus the higher the level if it's a mob. Never a penalty.
    if
        levelDiff > 0 and
        xi.combat.levelCorrection.isLevelCorrectedZone(actor) and
        not target:isPC()
    then
        magicEva = magicEva + levelDiff * 4
    end

    return magicEva
end

-- Magic Hit Rate. The function gets fed the result of both functions above.
xi.combat.magicHitRate.calculateMagicHitRate = function(magicAcc, magicEva)
    local magicAccDiff = magicAcc - magicEva

    if magicAccDiff < 0 then
        magicAccDiff = math.floor(magicAccDiff / 2)
    end

    local magicHitRate = utils.clamp(50 + magicAccDiff, 5, 95)

    return magicHitRate
end

xi.combat.magicHitRate.calculateResistRate = function(actor, target, skillType, spellElement, magicHitRate, rankModifier)
    local targetResistRate = 0 -- The variable we return.
    local targetResistRank = target:getMod(xi.combat.element.resistRankMod[spellElement])

    ----------------------------------------
    -- Handle "Magic Shield" status effect.
    ----------------------------------------
    if target:hasStatusEffect(xi.effect.MAGIC_SHIELD, 0) then
        return targetResistRate
    end

    ----------------------------------------
    -- Handle target resistance rank.
    ----------------------------------------
    -- Elemental resistance rank.
    if spellElement ~= xi.magic.ele.NONE then
        if targetResistRank > 4 then
            targetResistRank = utils.clamp(targetResistRank - rankModifier, 4, 11)
        end
    end

    -- Skillchains lowers target resistance rank by 1.
    local _, skillchainCount = FormMagicBurst(spellElement, target)

    if skillchainCount > 0 then
        targetResistRank = targetResistRank - 1
    end

    -- TODO: Rayke logic might be needed here, depending on how it's implemented.

    ----------------------------------------
    -- Handle magic hit rate.
    ----------------------------------------
    if targetResistRank >= 10 then
        magicHitRate = 5
    end

    ----------------------------------------
    -- Calculate first 3 resist tiers.
    ----------------------------------------
    local resistTier = 0
    local randomVar  = math.random()

    -- NOTE: Elemental magic evasion "Boons".
    -- According to wiki, 1 positive point in the spell element MEVA allows for an additional tier. This would be tier 3, not the resistance rank tier.
    -- However, it also states that a negative value will also prevent full resists, which is redundant. We already wouldnt be eligible for it.

    for tierVar = 3, 1, -1 do
        if randomVar <= (1 - magicHitRate / 100) ^ tierVar then
            resistTier = tierVar
            break
        end
    end

    targetResistRate = 1 / (2 ^ resistTier)

    -- Force 1/8 if target has max resistance rank.
    if targetResistRank >= 11 then
        -- TODO: Immunobreak logic probably goes here

        targetResistRate = 0.125
    end

    -- Force just 1/2 resist tier if target resistance rank is -3 (150% EEM).
    if
        targetResistRank <= -3 and -- Very weak.
        targetResistRate < 0.5     -- More than 1 resist tier triggered.
    then
        targetResistRate = 0.5
    end

    ----------------------------------------
    -- Calculate additional resist tier.
    ----------------------------------------
    if
        not actor:hasStatusEffect(xi.effect.SUBTLE_SORCERY) and -- Subtle sorcery bypasses this tier.
        targetResistRank >= 4 and                               -- Forced only at and after rank 4 (50% EEM).
        skillType == xi.skill.ELEMENTAL_MAGIC                   -- Only applies to nukes.
    then
        targetResistRate = targetResistRate / 2
    end

    return targetResistRate
end
