-----------------------------------
-- Land of Sacred Serpents
-- Aht Uhrgan Mission 1
-----------------------------------
-- NOTE: xi.mission.id.zilart.THE_NEW_FRONTIER is set on character creation
-- !addmission 4 0
-----------------------------------
require("scripts/globals/keyitems")
require('scripts/globals/missions')
require('scripts/globals/settings')
require('scripts/globals/interaction/mission')
require('scripts/globals/zone')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.TOAU, xi.mission.id.toau.LAND_OF_SACRED_SERPENTS)

mission.reward =
{
    keyItem     = xi.ki.SUPPLIES_PACKAGE,
    nextMission = { xi.mission.log_id.TOAU, xi.mission.id.toau.IMMORTAL_SENTRIES },
}

mission.sections =
{
    {
        -- NOTE: I don't know HOW would someone get to Whitegate without the Boarding Permit Key Item, but it's probably for the best to add the additional check.
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and
                   ENABLE_TOAU == 1 and
                   player:hasKeyItem(xi.ki.BOARDING_PERMIT)
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {

            -- TODO: Edit region defined in Aht Urghan Whitegate, becouse as of now, it is incorrect.
            -- CS should trigger in the ramp inside Naja Salaheem building.
            onRegionEnter =
            {
                [3] = function (player, csid, option, npc)
                    return mission:progressEvent(3000)
                end,
            },

            onEventFinish =
            {
                [3000] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
