ESX = nil
local currentAdminPlayers = {}
local owned = false
local ownedGroup

Citizen.CreateThread(function()
    while ESX == nil do
        ESX = exports["es_extended"]:getSharedObject()
        Citizen.Wait(0)
    end
end)


RegisterNetEvent('relisoft_tag:owned')
AddEventHandler('relisoft_tag:owned',function(own,group)
    owned = own
    if own then
        ownedGroup = group
        if Config.UseMythic then
		exports['mythic_notify']:DoHudText('success', Config.TagOn)
        else
        TriggerEvent('chat:addMessage', { args = { 'Server » ', Config.TagOn }, color = { 255, 50, 50 } })
        end
    else
        if Config.UseMythic then
		exports['mythic_notify']:DoHudText('error', Config.TagOff)
        else
        TriggerEvent('chat:addMessage', { args = { 'Server » ', Config.TagOff }, color = { 255, 50, 50 } })
        end
    end
end)

RegisterNetEvent('relisoft_tag:set_admins')
AddEventHandler('relisoft_tag:set_admins',function (admins)
    currentAdminPlayers = admins
    for id,admin in pairs(currentAdminPlayers) do
        if admins[id] == nil then
            currentAdminPlayers[id] = nil
        end
    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded',function()
    ESX.TriggerServerCallback('relisoft_tag:getAdminsPlayers',function(admins)
        currentAdminPlayers = admins
    end)
end)

local function RGBRainbow( frequency )
	local result = {}
	local curtime = GetGameTimer() / Config.RGBSpeed

	result.r = math.floor( math.sin( curtime * frequency + 0 ) * 127 + 128 )
	result.g = math.floor( math.sin( curtime * frequency + 2 ) * 127 + 128 )
	result.b = math.floor( math.sin( curtime * frequency + 4 ) * 127 + 128 )
	
	return result
end


Citizen.CreateThread(function ()

    while true do
        Citizen.Wait(0)

        local currentPed = PlayerPedId()
        local currentPos = GetEntityCoords(currentPed) 

        local cx,cy,cz = table.unpack(currentPos)
        cz = cz + 0.9

        if owned then
            DrawText3D(cx,cy,cz, Config.TagLabel)
        end

        for k, v in pairs(currentAdminPlayers) do
            local adminId = GetPlayerFromServerId(v.source)
            local adminPed = GetPlayerPed(adminId)
            local adminCoords = GetEntityCoords(adminPed)
            local x,y,z = table.unpack(adminCoords)
            z = z + 0.9

            if adminId ~= -1 then 
                local distance = GetDistanceBetweenCoords(vector3(cx,cy,cz), x,y,z, true)
                local label = Config.TagLabel
                if label then
                    if distance < 25 then
                        DrawText3D(x, y, z, label)
                    end
                end
            end
        end
    end

end)



function DrawText3D(x,y,z, text)
	local onScreen, _x, _y = World3dToScreen2d(x, y, z)
	local p = GetGameplayCamCoords()
	local distance = GetDistanceBetweenCoords(p.x, p.y, p.z, x, y, z, 1)
	local scale = (1 / distance) * 2
	local fov = (1 / GetGameplayCamFov()) * 100
	local scale = scale * fov
    	local rainbow = RGBRainbow( 1 )
	if onScreen then
		  SetTextScale(0.35, 0.31)
		  SetTextFont(13)
		  SetTextProportional(1)
		  SetTextOutline()
         
          SetTextColour(rainbow.r,rainbow.g, rainbow.b, 255)
		  SetTextDropshadow(10, 100, 100, 100, 255)
		  SetTextEntry("STRING")
		  SetTextCentre(1)
		  AddTextComponentString(text)
		  DrawText(_x,_y)
		  local factor = (string.len(text)) / 600
		  DrawRect(_x,_y+0.012, 0.040+ factor, 0.030, 0, 0, 0, 120)
	  end
end


--[[

]]--
