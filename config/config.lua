Config = {}
Config.SeeOwnLabel = true --If admin see his tag
Config.SeeDistance = 100 -- Distance, from what player can see.. 
Config.TextSize = 0.8 -- Size of text.. this you need to edit in clinet.lua.. cuze custom draw
Config.ZOffset = 2.2 --Size of text offset.. this you need to edit in clinet.lua.. cuze custom draw
Config.NearCheckWait = 500 --Some shit for optimalization 
Config.TagByPermission = true --Using xPlayer.getPermissions() which is deprecated method for old ESX



Config.TagLabel = 'STAFF'
Config.UseMythic = false -- Use mythic notify or chat message
Config.TagCommand = 'tag' -- Command pro zapnutí tagu
Config.TagOn = 'Tvůj tag byl zapnut prosim nezapomeň si ho vypnout'
Config.TagOff = 'Tvůj tag byl vypnout děkuji že si nezneužil práv'
Config.TagNoPerms = 'Nemáš právo na zapnutí tagu'
Config.RGBSpeed = 500 -- Bigger = slower



























--- This system don't work, cuze RGB text :) 
Config.GroupLabels = {
    admin = "~b~STAFF",
    lvedeni = "~r~VEDENI",
}
--- This system don't work, cuze RGB text :) 
Config.PermissionLabels = {
    [1] = "HELPER",
    [2] = "~g~MODERATOR",
    [3] = "~b~ADMINISTRATOR",
    [4] = "~r~GOD",
    [5] = "~r~GOD",
}
