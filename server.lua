local QBCore = exports['qb-core']:GetCoreObject()


RegisterNetEvent('torpak-policemegaphone:applySubmix', function(bool)
    TriggerClientEvent('torpak-policemegaphone:updateSubmixStatus', -1, bool, source)
end)

QBCore.Functions.CreateUseableItem("megaphone", function(source, item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.Functions.GetItemByName(item.name) then
        TriggerClientEvent("torpak-policemegaphone:useitem", source)
    end
end)