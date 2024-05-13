-----------------------------------
-- Area: Promyvion-Mea
-----------------------------------
zones = zones or {}

zones[xi.zone.PROMYVION_MEA] =
{
    text =
    {
        NOTHING_HAPPENS               = 119,  -- Nothing happens...
        ITEM_CANNOT_BE_OBTAINED       = 6384, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6390, -- Obtained: <item>.
        GIL_OBTAINED                  = 6391, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6393, -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY       = 6404, -- There is nothing out of the ordinary here.
        CARRIED_OVER_POINTS           = 7001, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7002, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7003, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7023, -- Your party is unable to participate because certain members' levels are restricted.
        BARRIER_WOVEN                 = 7226, -- It appears to be a barrier woven from the energy of overflowing memories...
        EERIE_GREEN_GLOW              = 7228, -- The sphere is emitting an eerie green glow.
    },
    mob =
    {
        MEMORY_RECEPTACLES =
        {
            [16859155] = { 1, 3, 16859483 },
            [16859205] = { 2, 5, 16859486 },
            [16859212] = { 2, 5, 16859490 },
            [16859219] = { 2, 5, 16859491 },
            [16859226] = { 2, 5, 16859492 },
            [16859296] = { 3, 7, 16859484 },
            [16859305] = { 3, 7, 16859485 },
            [16859314] = { 3, 7, 16859487 },
            [16859376] = { 4, 7, 16859488 },
            [16859385] = { 4, 7, 16859489 },
            [16859394] = { 4, 7, 16859493 },
        },

        COVETER = GetFirstID('Coveter'),
    },
    npc =
    {
        MEMORY_STREAM_OFFSET = GetFirstID('_0k1'),
    },
}

return zones[xi.zone.PROMYVION_MEA]
