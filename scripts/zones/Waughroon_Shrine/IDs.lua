-----------------------------------
-- Area: Waughroon_Shrine
-----------------------------------
zones = zones or {}

zones[xi.zone.WAUGHROON_SHRINE] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6384, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6390, -- Obtained: <item>.
        GIL_OBTAINED                  = 6391, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6393, -- Obtained key item: <keyitem>.
        LOST_KEYITEM                  = 6394, -- Lost key item: <keyitem>.
        CARRIED_OVER_POINTS           = 7001, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7002, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7003, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7023, -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                 = 7061, -- Tallying conquest results...
        TIME_IN_THE_BATTLEFIELD_IS_UP = 7225, -- Your time in the battlefield is up! Now exiting...
        NO_BATTLEFIELD_ENTRY          = 7239, -- A cursed seal has been placed upon this platform.
        PARTY_MEMBERS_ARE_ENGAGED     = 7240, -- The battlefield where your party members are engaged in combat is locked. Access is denied.
        TESTIMONY_IS_TORN             = 7283, -- Your <item> is torn...
        TESTIMONY_WEARS               = 7284, -- Your <item> [/rips into shreds!/is on the verge of tearing apart.../is showing signs of wear...] (# [use remains/uses remain].)
        MEMBERS_OF_YOUR_PARTY         = 7531, -- Currently, # members of your party (including yourself) have clearance to enter the battlefield.
        MEMBERS_OF_YOUR_ALLIANCE      = 7532, -- Currently, # members of your alliance (including yourself) have clearance to enter the battlefield.
        TIME_LIMIT_FOR_THIS_BATTLE_IS = 7534, -- The time limit for this battle is <number> minutes.
        ORB_IS_CRACKED                = 7535, -- There is a crack in the %. It no longer contains a monster.
        A_CRACK_HAS_FORMED            = 7536, -- A crack has formed on the <item>, and the beast inside has been unleashed!
        PARTY_MEMBERS_HAVE_FALLEN     = 7570, -- All party members have fallen in battle. Now leaving the battlefield.
        THE_PARTY_WILL_BE_REMOVED     = 7577, -- If all party members' HP are still zero after # minute[/s], the party will be removed from the battlefield.
        ENTERING_THE_BATTLEFIELD_FOR  = 7598, -- Entering the battlefield for [The Rank 2 Final Mission/The Worm's Turn/Grimshell Shocktroopers/On My Way/A Thief in Norg!?/3, 2, 1.../Shattering Stars (RDM)/Shattering Stars (THF)/Shattering Stars (BST)/Birds of a Feather/Crustacean Conundrum/Grove Guardians/The Hills are Alive/Royal Jelly/The Final Bout/Up in Arms/Copycat/Operation Desert Swarm/Prehistoric Pigeons/The Palborough Project/Shell Shocked/Beyond Infinity/The Worm's Tail/Grimshell Shocktroopers/A Feast Most Dire/A.M.A.N. Trove (Mars)/A.M.A.N. Trove (Venus)/Invitation from Naji/Invitation from Naji and Co.]!
        YOU_DECIDED_TO_SHOW_UP        = 7691, -- So, you decided to show up. Now it's time to see what you're really made of, heh heh heh.
        LOOKS_LIKE_YOU_WERENT_READY   = 7692, -- Looks like you weren't ready for me, were you? Now go home, wash your face, and come back when you think you've got what it takes.
        YOUVE_COME_A_LONG_WAY         = 7693, -- Hm. That was a mighty fine display of skill there, <name>. You've come a long way...
        TEACH_YOU_TO_RESPECT_ELDERS   = 7694, -- I'll teach you to respect your elders!
        TAKE_THAT_YOU_WHIPPERSNAPPER  = 7695, -- Take that, you whippersnapper!
        NOW_THAT_IM_WARMED_UP         = 7696, -- Now that I'm warmed up...
        THAT_LL_HURT_IN_THE_MORNING   = 7697, -- Ungh... That'll hurt in the morning...
        ONE_TENTACLE_WOUNDED          = 7715, -- One of the sea creature's tentacles have been wounded.
        ALL_TENTACLES_WOUNDED         = 7716, -- All of the sea creature's tentacles have been wounded.
        SCORPION_IS_STUNNED           = 7717, -- The platoon scorpion does not have enough energy to attack!
        SCORPION_IS_BOUND             = 7718, -- The platoon scorpion's legs are lodged in the rocks!
        SOUL_GEM_REACTS               = 7719, -- The <keyitem> reacts to the <keyitem>, sending a jolt of energy through your veins!
        PROMISE_ME_YOU_WONT_GO_DOWN   = 7734, -- Promise you won't go down too easy, okay?
        IM_JUST_GETTING_WARMED_UP     = 7735, -- Haha! I'm just getting warmed up!
        YOU_PACKED_MORE_OF_A_PUNCH    = 7736, -- Hah! You pack more of a punch than I thoughtaru. But I won't go down as easy as old Maat!
        WHATS_THIS_STRANGE_FEELING    = 7737, -- What's this strange feeling...? It's not supposed to end...like...
        HUH_IS_THAT_ALL               = 7738, -- Huh? Is that all? I haven't even broken a sweataru...
        YIKEY_WIKEYS                  = 7739, -- Yikey-wikeys! Get that thing away from meee!
        WHATS_THE_MATTARU             = 7740, -- <Pant, wheeze>... What's the mattaru, <name>? Too much of a pansy-wansy to fight fair?
    },

    mob =
    {
        ATORI_TUTORI = GetFirstID('Atori-Tutori_qm')
    },

    npc =
    {
    },

    operationDesertSwarm =
    {
        [1] =
        {
            17367266,
            17367267,
            17367268,
            17367269,
            17367270,
            17367271,
        },

        [2] =
        {
            17367273,
            17367274,
            17367275,
            17367276,
            17367277,
            17367278,
        },

        [3] =
        {
            17367280,
            17367281,
            17367282,
            17367283,
            17367284,
            17367285,
        },
    },
}

return zones[xi.zone.WAUGHROON_SHRINE]
