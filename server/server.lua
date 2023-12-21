local trainspawned = false
local trainHost = nil
local choosingRandom = nil

RegisterServerEvent("FiveM-Trains:PlayerSpawned")
AddEventHandler('FiveM-Trains:PlayerSpawned', function()
    local _source = source
	ChooseRandomPlayer(_source)
    SpawnTrain(_source)
end)

AddEventHandler('playerDropped', function(reason)
    local _source = source
    if trainHost == _source then
        trainspawned = false
        trainHost = nil
        ChooseRandomPlayer(_source)
    end
end)

RegisterServerEvent("FiveM-Trains:SelectRandomPlayer")
AddEventHandler('FiveM-Trains:SelectRandomPlayer', function()
    if not choosingRandom then
        choosingRandom = source
        ChooseRandomPlayer(0)
    end
end)

function ChooseRandomPlayer(leaver)
    local hostfound = false
    local players = GetPlayers()

    if #players > 1 then
        for i, player in ipairs(players) do
            if player == leaver then
                table.remove(players, i)
                break  
            end
        end

        local randomIndex = math.random(1, #players)
        local randomPlayer = players[randomIndex]
        SpawnTrain(randomPlayer)
        hostfound = true
        choosingRandom = nil
    end

    if not hostfound then
        print ("No Players in server (Trains Shutting Down)")
    end
end


function SpawnTrain(player)
    if not trainHost then
        if not trainspawned then
            TriggerClientEvent('StartTrain', tonumber(player))
            trainspawned = true
            trainHost = player
        end
    end
end
