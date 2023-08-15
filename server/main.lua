ESX = exports["es_extended"]:getSharedObject()

AdminPlayers = {}

RegisterCommand(Config.TagCommand, function(source,args)
    local xPlayer = ESX.GetPlayerFromId(source)
    local group = xPlayer.getGroup()
    if group ~= 'user' then
        if AdminPlayers[source] == nil then
            AdminPlayers[source] = {source = source, group = group}
            if Config.UseMythic then
            ExecuteCommand("users") 
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = Config.TagOn})
            else
            TriggerClientEvent('chat:addMessage',source, { args = { 'Server » ', Config.TagOn }, color = { 255, 50, 50 } })
            end
        else
            AdminPlayers[source] = nil
            if Config.UseMythic then
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = Config.TagOff})
            else
            TriggerClientEvent('chat:addMessage',source, { args = { 'Server » ', Config.TagOff }, color = { 255, 50, 50 } })
            end
        end
        TriggerClientEvent('relisoft_tag:set_admins',-1, AdminPlayers)
    else
        if Config.UseMythic then
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = Config.TagNoPerms})
        else
        TriggerClientEvent('chat:addMessage',source, { args = { 'Server » ', Config.TagNoPerms }, color = { 255, 50, 50 } })
        end
    end
end)

ESX.RegisterServerCallback('relisoft_tag:getAdminsPlayers',function(source,cb)
    cb(AdminPlayers)
end)

AddEventHandler('esx:playerDropped', function(source)
    if AdminPlayers[source] ~= nil then
        AdminPlayers[source] = nil
    end
    TriggerClientEvent('relisoft_tag:set_admins',-1,AdminPlayers)
end)



--[[

 NLRP & Relisoft Tag System - Edited

]]--