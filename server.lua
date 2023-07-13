RegisterNetEvent('megaphone:applySubmix', function(bool)
    TriggerClientEvent('megaphone:updateSubmixStatus', -1, bool, source)
end)