require('modules/module_utils')
require('scripts/globals/player')

local m = Module:new('new_player')

m:addOverride('xi.player.charCreate', function(player)
    player:addItem(xi.item.CHOCOBO_SHIRT)
    player:addItem(xi.item.DESTRIER_BERET)

    super(player)
end)

return m