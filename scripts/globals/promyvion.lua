xi = xi or {}
xi.promyvion = xi.promyvion or {}

-----------------------------------
-- Local functions
-----------------------------------
local function maxFloor(ID)
    local m = 0

    for _, v in pairs(ID.mob.MEMORY_RECEPTACLES) do
        m = math.max(m, v[1])
    end

    return m
end

local function randomizeFloorExit(ID, floor)
    local streams = {}

    for _, v in pairs(ID.mob.MEMORY_RECEPTACLES) do
        if v[1] == floor then
            GetNPCByID(v[3]):setLocalVar('[promy]floorExit', 0)
            table.insert(streams, v[3])
        end
    end

    local exitStreamId = streams[math.random(#streams)]
    GetNPCByID(exitStreamId):setLocalVar('[promy]floorExit', 1)
end

local function findMother(mob)
    local ID = zones[mob:getZoneID()]
    local mobId = mob:getID()
    local mother = 0
    for k, v in pairs(ID.mob.MEMORY_RECEPTACLES) do
        if k < mobId and k > mother then
            mother = k
        end
    end

    return mother
end

-----------------------------------
-- Zone global functions
-----------------------------------
xi.promyvion.handlePortal = function(player, npcId, eventId)
    if
        player:getAnimation() == xi.anim.NONE and
        GetNPCByID(npcId):getAnimation() == xi.anim.OPEN_DOOR
    then
        player:startOptionalCutscene(eventId)
    end
end

xi.promyvion.initZone = function(zone)
    local ID = zones[zone:getID()]

    -- randomize floor exits
    for i = 1, maxFloor(ID) do
        randomizeFloorExit(ID, i)
    end
end

-----------------------------------
-- Stray global functions
-----------------------------------
xi.promyvion.strayOnSpawn = function(mob)
    local mother = GetMobByID(findMother(mob))

    if mother ~= nil and mother:isSpawned() then
        mob:setPos(mother:getXPos(), mother:getYPos() - 5, mother:getZPos())
        mother:setAnimationSub(1)
    end
end

-----------------------------------
-- Memory Receptacle global functions
-----------------------------------
xi.promyvion.receptacleOnFight = function(mob, target)
    if os.time() > mob:getLocalVar('[promy]nextStray') then
        local ID = zones[mob:getZoneID()]
        local mobId = mob:getID()
        local numStrays = ID.mob.MEMORY_RECEPTACLES[mobId][2]

        for i = mobId + 1, mobId + numStrays do
            local stray = GetMobByID(i)
            if not stray:isSpawned() then
                mob:setLocalVar('[promy]nextStray', os.time() + 20)
                stray:spawn()
                stray:updateEnmity(target)
                break
            end
        end
    else
        mob:setAnimationSub(2)
    end
end

xi.promyvion.receptacleOnDeath = function(mob, optParams)
    if optParams.isKiller then
        local ID = zones[mob:getZoneID()]
        local mobId = mob:getID()
        local floor = ID.mob.MEMORY_RECEPTACLES[mobId][1]
        local streamId = ID.mob.MEMORY_RECEPTACLES[mobId][3]
        local stream = GetNPCByID(streamId)

        mob:setAnimationSub(0)

        -- open floor exit portal
        if stream:getLocalVar('[promy]floorExit') == 1 then
            randomizeFloorExit(ID, floor)
            local events = ID.npc.MEMORY_STREAMS[streamId][7]
            local event = events[math.random(#events)]
            stream:setLocalVar('[promy]destination', event)
            stream:openDoor(180)
        end
    end
end
