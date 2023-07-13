RegisterNetEvent('torpak-policemegaphone:applySubmix', function(bool)
    TriggerClientEvent('torpak-policemegaphone:updateSubmixStatus', -1, bool, source)
end)