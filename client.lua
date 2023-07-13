local QBCore = exports['qb-core']:GetCoreObject()
local PlayerData = {}

RegisterNetEvent('QBCore:Player:SetPlayerData', function(val)
  PlayerData = val
end)

local function CheckPlayer()
  local Player = PlayerPedId()
  local getVehiclePedIsIn = GetVehiclePedIsIn(Player, false) > 0 and GetVehiclePedIsIn(Player, false) or
      0 -- Get the vehicle the ped is in, if is > than 0 means the player is in a vehicle
  if getVehiclePedIsIn == 0 then return end
  local vehicleClass = GetVehicleClass(getVehiclePedIsIn) == 18 and true or false --get the class of it
  if not vehicleClass then
    return
  end
  return vehicleClass
end

--https://cookbook.fivem.net/2020/01/06/using-the-new-console-key-bindings/
RegisterCommand('+Megaphoneaga', function()
  if not PlayerData.job then PlayerData = QBCore.Functions.GetPlayerData() end
  if PlayerData.job.name == "police" and CheckPlayer() then
    exports["pma-voice"]:overrideProximityRange(60.0, true)
    TriggerServerEvent('megaphone:applySubmix', true)
    QBCore.Functions.Notify('Megafon Devrede', 'success')
  end
end, false)

local data = {
    [`default`] = 0,
    [`freq_low`] = 0.0,
    [`freq_hi`] = 10000.0,
    [`rm_mod_freq`] = 300.0,
    [`rm_mix`] = 0.2,
    [`fudge`] = 0.0,
    [`o_freq_lo`] = 200.0,
    [`o_freq_hi`] = 5000.0,
}

local filter

CreateThread(function()
    filter = CreateAudioSubmix("Megaphone")
    SetAudioSubmixEffectRadioFx(filter, 0)
    for hash, value in pairs(data) do
        SetAudioSubmixEffectParamInt(filter, 0, hash, 1)
    end
    AddAudioSubmixOutput(filter, 0)
end)

RegisterNetEvent('megaphone:updateSubmixStatus', function(state, source)
    if state then
        MumbleSetSubmixForServerId(source, filter)
    else
        MumbleSetSubmixForServerId(source, -1)
    end
end)

CreateThread(function()
    filter = CreateAudioSubmix("Megaphone")
    SetAudioSubmixEffectRadioFx(filter, 0)
    for hash, value in pairs(data) do
        SetAudioSubmixEffectParamInt(filter, 0, hash, 1)
    end
    AddAudioSubmixOutput(filter, 0)
end)

RegisterCommand('-Megaphoneaga', function()

  if not PlayerData.job then PlayerData = QBCore.Functions.GetPlayerData() end
  if PlayerData.job.name == "police" and CheckPlayer() then
    exports["pma-voice"]:clearProximityOverride()
    QBCore.Functions.Notify('Megafon Devre Dışı', 'error')
    TriggerServerEvent('megaphone:applySubmix', false)
  end
end, false)

RegisterKeyMapping('+Megaphoneaga', 'Megafon', 'keyboard', 'LSHIFT')

RegisterNetEvent('megaphone:updateSubmixStatus', function(state, source)
  if state then
      MumbleSetSubmixForServerId(source, filter)
  else
      MumbleSetSubmixForServerId(source, -1)
  end
end)