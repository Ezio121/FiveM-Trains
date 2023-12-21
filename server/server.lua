local IsPlayerNearMetro = false
local IsPlayerInMetro = false
local PlayerHasMetroTicket = false
local IsPlayerUsingTicketMachine = false
local ShowingExitMetroMessage = false
local EverythingisK = false
local Train = nil
local MetroTrain = nil
local MetroTrain2 = nil
local Driver1 = nil
local Driver2 = nil
local Driver3 = nil
local MetroTrainStopped = {}

--===================================================
-- These are radius locations (multiple per station)
-- to detect if the player can exit the Metro
--===================================================
local XNLMetroScanPoints = {
	{XNLStationid=0, x=230.82389831543, y=-1204.0643310547, z=38.902523040771},
	{XNLStationid=0, x=249.59216308594, y=-1204.7095947266, z=38.92488861084},
	{XNLStationid=0, x=270.33166503906, y=-1204.5366210938, z=38.902912139893},
	{XNLStationid=0, x=285.96697998047, y=-1204.2261962891, z=38.929733276367},
	{XNLStationid=0, x=304.13528442383, y=-1204.3720703125, z=38.892612457275},
	{XNLStationid=1, x=-294.53421020508, y=-353.38571166992, z=10.063089370728},
	{XNLStationid=1, x=-294.96997070313, y=-335.69766235352, z=10.06309223175},
	{XNLStationid=1, x=-294.66772460938, y=-318.29565429688, z=10.063152313232},
	{XNLStationid=1, x=-294.73403930664, y=-303.77200317383, z=10.063160896301},
	{XNLStationid=1, x=-294.84133911133, y=-296.04568481445, z=10.063159942627},
	{XNLStationid=2, x=-795.28063964844, y=-126.3436050415, z=19.950298309326},
	{XNLStationid=2, x=-811.87170410156, y=-136.16409301758, z=19.950319290161},
	{XNLStationid=2, x=-819.25689697266, y=-140.25764465332, z=19.95037651062},
	{XNLStationid=2, x=-826.06652832031, y=-143.90898132324, z=19.95037651062},
	{XNLStationid=2, x=-839.2587890625, y=-151.32421875, z=19.950378417969},
	{XNLStationid=2, x=-844.77874755859, y=-154.31440734863, z=19.950380325317},
	{XNLStationid=3, x=-1366.642578125, y=-440.04803466797, z=15.045327186584},
	{XNLStationid=3, x=-1361.4998779297, y=-446.50497436523, z=15.045324325562},
	{XNLStationid=3, x=-1357.4061279297, y=-453.40963745117, z=15.045320510864},
	{XNLStationid=3, x=-1353.4593505859, y=-461.88238525391, z=15.045323371887},
	{XNLStationid=3, x=-1346.1264648438, y=-474.15142822266, z=15.045383453369},
	{XNLStationid=3, x=-1338.1717529297, y=-488.97756958008, z=15.045383453369},
	{XNLStationid=3, x=-1335.0261230469, y=-493.50796508789, z=15.045380592346},
	{XNLStationid=4, x=-530.67529296875, y=-673.33935546875, z=11.808959960938},
	{XNLStationid=4, x=-517.35559082031, y=-672.76635742188, z=11.808965682983},
	{XNLStationid=4, x=-499.44836425781, y=-673.37664794922, z=11.808973312378},
	{XNLStationid=4, x=-483.1321105957, y=-672.68438720703, z=11.809024810791},
	{XNLStationid=4, x=-468.05545043945, y=-672.74371337891, z=11.80902671814},
	{XNLStationid=5, x=-206.90379333496, y=-1014.9454345703, z=30.138082504272},
	{XNLStationid=5, x=-212.65534973145, y=-1031.6101074219, z=30.208702087402},
	{XNLStationid=5, x=-212.65534973145, y=-1031.6101074219, z=30.208702087402},
	{XNLStationid=5, x=-217.0216217041, y=-1042.4768066406, z=30.573789596558},
	{XNLStationid=5, x=-221.29409790039, y=-1054.5914306641, z=30.13950920105},
	{XNLStationid=6, x=101.89681243896, y=-1714.7589111328, z=30.112174987793},
	{XNLStationid=6, x=113.05246734619, y=-1724.7247314453, z=30.111650466919},
	{XNLStationid=6, x=122.72943878174, y=-1731.7276611328, z=30.54141998291},
	{XNLStationid=6, x=132.55198669434, y=-1739.7276611328, z=30.109527587891},
	{XNLStationid=7, x=-532.24133300781, y=-1263.6896972656, z=26.901586532593},
	{XNLStationid=7, x=-539.62115478516, y=-1280.5207519531, z=26.908163070679},
	{XNLStationid=7, x=-545.18548583984, y=-1290.9525146484, z=26.901586532593},
	{XNLStationid=7, x=-549.92230224609, y=-1302.8682861328, z=26.901605606079},
	{XNLStationid=8, x=-872.75714111328, y=-2289.3198242188, z=-11.732793807983},
	{XNLStationid=8, x=-875.53247070313, y=-2297.67578125, z=-11.732793807983},
	{XNLStationid=8, x=-880.05035400391, y=-2309.1235351563, z=-11.732788085938},
	{XNLStationid=8, x=-883.25482177734, y=-2321.3303222656, z=-11.732738494873},
	{XNLStationid=8, x=-890.087890625, y=-2336.2553710938, z=-11.732738494873},
	{XNLStationid=8, x=-894.92395019531, y=-2350.4128417969, z=-11.732727050781},
	{XNLStationid=9, x=-1062.7882080078, y=-2690.7492675781, z=-7.4116077423096},
	{XNLStationid=9, x=-1071.6839599609, y=-2701.8503417969, z=-7.410071849823},
	{XNLStationid=9, x=-1079.0869140625, y=-2710.7033691406, z=-7.4100732803345},
	{XNLStationid=9, x=-1086.8758544922, y=-2720.0673828125, z=-7.4101362228394},
	{XNLStationid=9, x=-1095.3796386719, y=-2729.8442382813, z=-7.4101347923279},
	{XNLStationid=9, x=-1103.7401123047, y=-2740.369140625, z=-7.4101300239563}
}

local XNLMetroEXITPoints = {
	{XNLStationid=0, x=294.46011352539, y=-1203.5991210938, z=38.902496337891, h=90.168075561523},
	{XNLStationid=1, x=-294.76913452148, y=-303.44619750977, z=10.063159942627, h=185.19216918945},
	{XNLStationid=2, x=-839.20843505859, y=-151.43312072754, z=19.950380325317, h=298.70877075195},
	{XNLStationid=3, x=-1337.9787597656, y=-488.36145019531, z=15.045375823975, h=28.487064361572},
	{XNLStationid=4, x=-474.07037353516, y=-673.10729980469, z=11.809032440186, h=81.799621582031},
	{XNLStationid=5, x=-222.13038635254, y=-1054.5043945313, z=30.139930725098, h=155.81954956055},
	{XNLStationid=6, x=133.13328552246, y=-1739.5617675781, z=30.109495162964, h=231.40335083008},
	{XNLStationid=7, x=-550.79998779297, y=-1302.4467773438, z=26.901605606079, h=155.53070068359},
	{XNLStationid=8, x=-891.87664794922, y=-2342.6486816406, z=-11.732737541199, h=353.59387207031},
	{XNLStationid=9, x=-1099.6376953125, y=-2734.8957519531, z=-7.410129070282, h=314.91424560547}
}

-- This is all our "Stop" station for the metro.
local MetroTrainstops = {
	-- Los Santos AirPort (airport front door entrance)
	{x=-1088.627, y=-2709.362, z=-7.137033},
	{x=-1081.309, y=-2725.259, z=-7.137033},

	-- Los Santos AirPort (car park/highway entrance)
	{x=-889.2755, y=-2311.825, z=-11.45941},
	{x=-876.7512, y=-2323.808, z=-11.45609},
	
	-- Little Seoul (near los santos harbor)
	{x=-545.3138, y=-1280.548, z=27.09238},
	{x=-536.8082, y=-1286.096, z=27.08238},
	
	-- Strawberry (near strip club)
	{x=270.2029, y=-1210.818, z=39.25398},
	{x=265.3616, y=-1198.051, z=39.23406},
	
	-- Rockford Hills (San Vitus Blvd)
	{x=-286.3837, y=-318.877, z=10.33625},
	{x=-302.6719, y=-322.995, z=10.33629},
	
	-- Rockford Hills (Near golf club)
	{x=-826.3845, y=-134.7151, z=20.22362},
	{x=-816.7159, y=-147.4567, z=20.2231},

	-- Del Perro (Near beach)
	{x=-1351.282, y=-481.2916, z=15.318},
	{x=-1341.085, y=-467.674, z=15.31838},
	
	-- Little Seoul
	{x=-496.0209, y=-681.0325, z=12.08264},
	{x=-495.8456, y=-665.4668, z=12.08244},

	-- Pillbox Hill (Downtown)
	{x=-218.2868, y=-1031.54, z=30.51112},
	{x=-209.6845, y=-1037.544, z=30.50939},

	-- Davis (Gang / hood area)
	{x=112.3714, y=-1729.233, z=30.24097},
	{x=120.0308, y=-1723.956, z=30.31433},
}

local TicketMachines = {'prop_train_ticket_02', 'prop_train_ticket_02_tu', 'v_serv_tu_statio3_'}
local anim = "mini@atmenter"
local has_loaded = false
Citizen.CreateThread(function()
    function LoadTrainModels()
        local models = {
            "freight",
            "freightcar",
            "freightgrain",
            "freightcont1",
            "freightcont2",
            "freighttrailer",
            "tankercar",
            "metrotrain",
            "s_m_m_lsmetro_01"
        }

        for _, model in ipairs(models) do
            local hash = GetHashKey(model)
            RequestModel(hash)

            while not HasModelLoaded(hash) do
                Citizen.Wait(0)
            end
        end
		has_loaded = true
        if Debug then
            print("FiveM-Trains: Train Models Loaded")
        end
    end

    LoadTrainModels()
end)




	local function CreateTrain(model, x, y, z, blipSprite, cruiseSpeed, isMetro)
		local train = CreateMissionTrain(model, x, y, z, isMetro)
		
		while not DoesEntityExist(train) do
			Wait(800)
		end
	
		if ShowTrainBlips then
			local trainBlip = AddBlipForEntity(train)
			SetBlipSprite(trainBlip, blipSprite)
			-- Add other blip settings here
		end
	
		SetTrainCruiseSpeed(train, cruiseSpeed)
	
		local driver = CreatePedInsideVehicle(train, 26, GetHashKey("s_m_m_lsmetro_01"), -1, 1, true)
	
		return train, driver
	end
	local has_spawned = false
	Citizen.CreateThread(function()
		RegisterNetEvent("StartTrain")
		AddEventHandler("StartTrain", function()
			local randomSpawn = math.random(#TrainLocations)
			local x, y, z = TrainLocations[randomSpawn][1], TrainLocations[randomSpawn][2], TrainLocations[randomSpawn][3]
			local yesorno = math.random(0, 100) >= 50
			Wait(100)
			while not has_spawned do 
				if has_loaded then 
					local freightTrain, freightDriver = CreateTrain(math.random(0, 22), x, y, z, 660, 20.0, yesorno)
					if Debug then
						print("FiveM-Trains: Train 1 created (Freight).")
					end
					local metroTrain, metroDriver = CreateTrain(24, 40.2, -1201.3, 31.0, 660, 15.0, true)
					if Debug then
						print("FiveM-Trains: Train 2 created (Metro).")
					end
			
					if UseTwoMetros == 1 then
						local metroTrain2, metroDriver2 = CreateTrain(24, -618.0, -1476.8, 16.2, 660, 15.0, true)
						if Debug then
							print("FiveM-Trains: Train 3 created (Metro #2).")
						end
					end
					has_spawned = true
				else
					Wait(500)
				end
				if Debug then
					print("FiveM-Trains: Train System Started, you are currently 'host' for the trains.")
				end
			end
		end)
	
		EverythingisK = true
	end)
	

Citizen.CreateThread(function()
	ShowedBuyTicketHelper = false
	ShowedLeaveMetroHelper = false
	while true do
		Wait(10)

		if IsPlayerNearTicketMachine then
			if not IsPlayerUsingTicketMachine  then
				if not ShowedBuyTicketHelper then
					DisplayHelpText(Message[Language]['buyticket'].." ($" .. TicketPrice .. ")")
					ShowedBuyTicketHelper = true
				end
			else
				ClearAllHelpMessages()
				DisableControlAction(0, 201, true)
				DisableControlAction(1, 201, true)
			end

			if IsControlJustPressed(0, 51) and PlayerHasMetroTicket then
				SMS_Message("CHAR_LS_TOURIST_BOARD", Message[Language]['los_santos_transit'], Message[Language]['tourist_information'], Message[Language]['already_got_ticket'], true)
				Wait(3500) 
			end

			if IsControlJustPressed(0, 51) and not PlayerHasMetroTicket then
				IsPlayerUsingTicketMachine = true
				RequestAnimDict("mini@atmbase")
				RequestAnimDict(anim)
				while not HasAnimDictLoaded(anim) do
					Wait(1)
				end

				SetCurrentPedWeapon(playerPed, GetHashKey("weapon_unarmed"), true)
				TaskLookAtEntity(playerPed, currentTicketMachine, 2000, 2048, 2)
				Wait(500)
				TaskGoStraightToCoord(playerPed, TicketMX, TicketMY, TicketMZ, 0.1, 4000, GetEntityHeading(currentTicketMachine), 0.5)
				Wait(2000)
				TaskPlayAnim(playerPed, anim, "enter", 8.0, 1.0, -1, 0, 0.0, 0, 0, 0)
				RemoveAnimDict(animDict)
				Wait(4000)
				TaskPlayAnim(playerPed, "mini@atmbase", "base", 8.0, 1.0, -1, 0, 0.0, 0, 0, 0)
				RemoveAnimDict("mini@atmbase")
				Wait(500)
				PlaySoundFrontend(-1, "ATM_WINDOW", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)

				RequestAnimDict("mini@atmexit")
				while not HasAnimDictLoaded("mini@atmexit") do
					Wait(1)
				end
				TaskPlayAnim(playerPed, "mini@atmexit", "exit", 8.0, 1.0, -1, 0, 0.0, 0, 0, 0)
				RemoveAnimDict("mini@atmexit")
				Wait(500)
-------------------------------------------------------
				BankAmount = 10000    
				PlayerCashAm = 10000  

				if PayWithBank == 1 then
					XNLUserMoney = BankAmount
				else
					XNLUserMoney = PlayerCashAm
				end

				if XNLUserMoney < TicketPrice then
					if UserBankIDi == 1 then		  	
						BankIcon = "CHAR_BANK_MAZE"
						BankName = "Maze Bank"
					end
					if UserBankIDi == 2 then			
						BankIcon = "CHAR_BANK_BOL"
						BankName = "Bank Of Liberty"
					end

					if UserBankIDi == 3 then		  		
						BankIcon = "CHAR_BANK_FLEECA"
						BankName = "Fleeca Bank"
					end
					SMS_Message(BankIcon, BankName, Message[Language]['account_information'], Message[Language]['account_nomoney'], true)
				else
					if PayWithBank == 1 then

					else
					end
-----------------------------------------------------------
					SMS_Message("CHAR_LS_TOURIST_BOARD", Message[Language]['los_santos_transit'], Message[Language]['tourist_information'], Message[Language]['ticket_purchased'], true)
					PlayerHasMetroTicket = true
				end

				IsPlayerUsingTicketMachine = false
			end
		else
			ShowedBuyTicketHelper = false
		end
		if IsControlJustPressed(0, 51) then
			playerPed = PlayerPedId()
			x,y,z = table.unpack(GetEntityCoords(playerPed, true))
			IsPlayerInVehicle = IsPedInAnyVehicle(playerPed, true)
			SkipReEnterCheck = false

			if IsPlayerInMetro then
				if XNLCanPlayerExitTrain() then
					if not XNLTeleportPlayerToNearestMetroExit() then
						SMS_Message("CHAR_LS_TOURIST_BOARD", Message[Language]['los_santos_transit'], Message[Language]['tourist_information'], Message[Language]['stop_toolate'], true)
					end
					SkipReEnterCheck = true 
				else
					XNLGenMess = "Sir"
					if XNLIsPedFemale(playerPed) then
						XNLGenMess = "Miss"
					end
					SMS_Message("CHAR_LS_TOURIST_BOARD", Message[Language]['los_santos_transit'], Message[Language]['tourist_information'], Message[Language]['sorry'].." "..Message[Language][XNLGenMess].." "..Message[Language]['exit_metro_random'], true)
				end
			end
			if not IsPlayerNearMetro and not IsPlayerInMetro and not SkipReEnterCheck then
				if not IsPlayerInVehicle then
					local coordA = GetEntityCoords(GetPlayerPed(-1), 1)
					local coordB = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 3.0, 0.0)
					local Metro = getVehicleInDirection(coordA, coordB)
					if DoesEntityExist(Metro) then
						if GetEntityModel(Metro) == GetHashKey("metrotrain") then
							if not PlayerHasMetroTicket	then
									SMS_Message("CHAR_LS_TOURIST_BOARD", Message[Language]['los_santos_transit'], Message[Language]['tourist_information'], Message[Language]['need_ticket'], true)
							else
								if IsPlayerWantedLevelGreater(PlayerId(), 0) and AllowEnterTrainWanted == 0 then
									SMS_Message("CHAR_LS_TOURIST_BOARD", Message[Language]['los_santos_transit'], Message[Language]['tourist_information'], Message[Language]['have_wantedlevel'], true)
								else
									CurrentMetro = Metro
									IsPlayerNearMetro = true
									if FreeWalk then
										MetroX, MetroY, MetroZ = table.unpack(GetOffsetFromEntityInWorldCoords(CurrentMetro, 0.0, 0.0, 0.0))
										SetEntityCoordsNoOffset(PlayerPedId(), MetroX, MetroY, MetroZ + 2.0)
									else							
										SetPedIntoVehicle(GetPlayerPed(-1), CurrentMetro, 1)
									end
									IsPlayerInMetro = true
									PlayerHasMetroTicket = false
									SMS_Message("CHAR_LS_TOURIST_BOARD", Message[Language]['los_santos_transit'], Message[Language]['tourist_information'], Message[Language]['entered_metro'], true)
								end
							end
						else
							IsPlayerNearMetro = false
						end
					else
						IsPlayerNearMetro = false
					end
				else
					if not DoesEntityExist(CurrentMetro) then
						IsPlayerNearMetro = false
					else
						if GetDistanceBetweenCoords(x,y,z, MetroX, MetroY, MetroZ, true) > 3.5 then
							IsPlayerNearMetro = false
						end
					end
				end
			end
		end

		if IsPlayerInMetro then
			if ReportTerroristOnMetro == true then
				if GetPlayerWantedLevel(PlayerId()) < 4 then
					if IsPedShooting(GetPlayerPed(-1)) then
						SetPlayerWantedLevel(PlayerId(), 4, 0)
						SetPlayerWantedLevelNow(PlayerId(), 0)
						SMS_Message("CHAR_LS_TOURIST_BOARD", Message[Language]['los_santos_transit'], Message[Language]['tourist_information'], Message[Language]['terrorist'], true)
					end
				end
			end

			if not DoesEntityExist(CurrentMetro) then
				IsPlayerNearMetro = false
				IsPlayerInMetro = false
				PlayerHasMetroTicket = true
				SMS_Message("CHAR_LS_TOURIST_BOARD", Message[Language]['los_santos_transit'], Message[Language]['tourist_information'], Message[Language]['no_metro_spawned'], true)
			else
				if IsPlayerInMetro then
					if ShowingExitMetroMessage == true and not ShowedLeaveMetroHelper then
						DisplayHelpText("Press ~INPUT_CONTEXT~ to leave the metro")
						ShowedLeaveMetroHelper = true
					end
					MetroX, MetroY, MetroZ = table.unpack(GetOffsetFromEntityInWorldCoords(CurrentMetro, 0.0, 0.0, 0.0))
					x,y,z = table.unpack(GetEntityCoords(playerPed, true))
					if GetDistanceBetweenCoords(x,y,z, MetroX, MetroY, MetroZ, true) > 15.0 then
						IsPlayerNearMetro = false
						IsPlayerInMetro = false
						SMS_Message("CHAR_LS_TOURIST_BOARD", Message[Language]['los_santos_transit'], Message[Language]['tourist_information'], Message[Language]['travel_metro'], true)
					end

				end
			end
		end

	end
end)

Citizen.CreateThread(function()
    local ShowedEToEnterMetro = false
    local IsPlayerNearTicketMachine = false
    local currentTicketMachine = nil

    while true do
        Wait(550)

        if IsPlayerInMetro then
            ShowingExitMetroMessage = XNLCanPlayerExitTrain()
            ShowedEToEnterMetro = false
        end

        if not IsPlayerInMetro then
            local playerPed = PlayerPedId()
            local IsPlayerInVehicle = IsPedInAnyVehicle(playerPed, true)

            if not IsPlayerInVehicle then
                if PlayerHasMetroTicket and XNLCanPlayerExitTrain() then
                    if not ShowedEToEnterMetro then
                        DisplayHelpText(Message[Language]['press_to_enter'])
                        ShowedEToEnterMetro = true
                    end
                else
                    ShowedEToEnterMetro = false
                end

                local x, y, z = table.unpack(GetEntityCoords(playerPed, true))

                if not IsPlayerNearTicketMachine then
                    for k, v in pairs(TicketMachines) do
                        local ticketMachine = GetClosestObjectOfType(x, y, z, 0.75, GetHashKey(v), false)
                        if DoesEntityExist(ticketMachine) then
                            currentTicketMachine = ticketMachine
                            local ticketMX, ticketMY, ticketMZ = table.unpack(GetOffsetFromEntityInWorldCoords(ticketMachine, 0.0, -.85, 0.0))
                            IsPlayerNearTicketMachine = true
                        end
                    end
                else
                    if not DoesEntityExist(currentTicketMachine) or GetDistanceBetweenCoords(x, y, z, TicketMX, TicketMY, TicketMZ, true) > 2.0 then
                        IsPlayerNearTicketMachine = false
                    end
                end
            end
        end
    end
end)


function SMS_Message(NotiPic, SenderName, Subject, MessageText, PlaySound)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(MessageText)
    SetNotificationBackgroundColor(140)
    SetNotificationMessage(NotiPic, NotiPic, true, 4, SenderName, Subject, MessageText)
    DrawNotification(false, true)
    if PlaySound then
        PlaySoundFrontend(GetSoundId(), "Text_Arrive_Tone", "Phone_SoundSet_Default", true)
    end
end

function DisplayHelpText(str)
    SetTextComponentFormat("STRING")
    AddTextComponentString(str)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
    EndTextCommandDisplayHelp(0, 0, true, 2000)
end

function getVehicleInDirection(coordFrom, coordTo)
    local rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 10, GetPlayerPed(-1), 0)
    local _, _, _, _, vehicle = GetRaycastResult(rayHandle)
    return vehicle
end

function XNLIsPedFemale(ped)
    return IsPedModel(ped, 'mp_f_freemode_01')
end

function XNLCanPlayerExitTrain()
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed, true)
    for _, item in pairs(XNLMetroScanPoints) do
        if GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, item.x, item.y, item.z, true) < StationsExitScanRadius then
            return true
        end
    end
    return false
end

function XNLTeleportPlayerToNearestMetroExit()
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed, true)
    for _, item in pairs(XNLMetroScanPoints) do
        if GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, item.x, item.y, item.z, true) < StationsExitScanRadius then
            for _, item2 in pairs(XNLMetroEXITPoints) do
                if item.XNLStationid == item2.XNLStationid then
                    DoScreenFadeOut(800)
                    while not IsScreenFadedOut() do
                        Wait(10)
                    end

                    SetEntityCoordsNoOffset(PlayerPedId(), item2.x, item2.y, item2.z)
                    SetEntityHeading(PlayerPedId(), item2.h)

                    DoScreenFadeIn(800)
                    while not IsScreenFadedIn() do
                        Wait(10)
                    end
                    return true
                end
            end
        end
    end
    return false
end


Citizen.CreateThread(function()
    while not EverythingisK do
        Citizen.Wait(0)
    end

    while true do
        Citizen.Wait(0)

        local closest = 10

        CheckAndStopTrain(MetroTrain)
        CheckAndStopTrain(MetroTrain2)
    end
end)

function CheckAndStopTrain(train)
    if DoesEntityExist(train) and not MetroTrainStopped[train] then
        local coords = GetEntityCoords(train)
        if coords then
            for _, stop in ipairs(MetroTrainstops) do
                if GetDistanceBetweenCoords(coords, stop.x, stop.y, stop.z, true) <= closest then
                    StopTrain(train)
                end
            end
        end
    end
end


function StopTrain(train)
    if NetworkHasControlOfEntity(train) then
        table.insert(MetroTrainStopped, train)
        SetTrainCruiseSpeed(train, 0.0)

        local stoppedTimer = GetGameTimer()
        repeat
            Citizen.Wait(0)
        until GetEntitySpeed(train) <= 0

        local stopDuration = 20 * 1000 -- 20 seconds
        local waitDuration = 5000 -- 5 seconds

        local elapsed = 0
        while elapsed < stopDuration do
            Citizen.Wait(0)
            elapsed = GetGameTimer() - stoppedTimer
        end

        SetTrainCruiseSpeed(train, 15.0)

        local timer = GetGameTimer()
        while GetGameTimer() - timer < waitDuration do
            removebyKey(MetroTrainStopped, train)
            Citizen.Wait(0)
        end
    end
end


local firstspawn = 0 

AddEventHandler('playerSpawned', function()
	while EverythingisK == false do Citizen.Wait(0) end 
	if firstspawn == 0 then 
		TriggerServerEvent('FiveM-Trains:PlayerSpawned')
		firstspawn = 1 
	end
end)
AddEventHandler('onResourceStop', function(resourceName)
	if (GetCurrentResourceName() ~= resourceName) then
		return
	end
	DeleteMissionTrain(MetroTrain)
	DeleteMissionTrain(MetroTrain2)
	DeleteMissionTrain(Train)
end)
