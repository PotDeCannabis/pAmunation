ESX = nil
 
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

-- Intéraction [E]

Citizen.CreateThread(function()
    while true do
        local wait = 900
        for k,v in pairs(Config.Positions) do
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, v.x, v.y, v.z)
            if dist <= 5 then 
                wait = 1                                                 
                DrawMarker(6, v.x, v.y, v.z-0.99, nil, nil, nil, -90, nil, nil, 1.0, 1.0, 1.0, 230, 230, 0 , 120)
             end
            if dist <= 2 then
                wait = 1
                Visual.Subtitle("Appuyer sur ~y~[E]~s~ pour accèder à ~y~l'Armurerie ~s~!", 1) 
                if IsControlJustPressed(1,51) then
                    OpenArmurerie()
                end
            end 
        end
    Citizen.Wait(wait)
    end
end)

-- Blips

Citizen.CreateThread(function()
    for k, v in pairs(Config.Positions) do
        local pos = Config.Positions
        local Blips = AddBlipForCoord(pos[k].x, pos[k].y, pos[k].z)
        SetBlipSprite(Blips, 110)
        SetBlipColour(Blips, 5)
        SetBlipScale(Blips, 0.7)
        SetBlipAsShortRange(Blips, true)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentString("Armurerie")
        EndTextCommandSetBlipName(Blips)
    Citizen.Wait(1)
    end
end)

-- NPC

CreateThread(function()
    local canCallJob = false
    for k, v in pairs(Config.NPC) do
        RequestModel(GetHashKey(v.typePed))
        while not HasModelLoaded(GetHashKey(v.typePed)) do
            Wait(1)
        end
        local npc = CreatePed(4, v.typePed, v.position.x, v.position.y, v.position.z-0.98, v.heading,  false, true)
        SetPedFleeAttributes(npc, 0, 0)
        SetPedDropsWeaponsWhenDead(npc, false)
        SetPedDiesWhenInjured(npc, false)
        SetEntityInvincible(npc , true)
        FreezeEntityPosition(npc, true)
        SetBlockingOfNonTemporaryEvents(npc, true)
    end
end)

-- Vérification PPA

function VerifPPA()
    ESX.TriggerServerCallback('esx_license:checkLicense', function(hasWeaponLicense)
        possessionppa = hasWeaponLicense
    end, GetPlayerServerId(PlayerId()), 'weapon')
end

-- Menu

local open = false 
local mainMenu = RageUI.CreateMenu('Armurerie', 'Moyens de payement')
local mainMenu2 = RageUI.CreateSubMenu(mainMenu, 'Armurerie', 'Actions armurerie')
local mainMenu3 = RageUI.CreateSubMenu(mainMenu2, 'Armurerie', 'Actions armurerie')
local mainMenu4 = RageUI.CreateSubMenu(mainMenu2, 'Armurerie', 'Actions armurerie')
local mainMenu5 = RageUI.CreateSubMenu(mainMenu, 'Armurerie', 'Actions armurerie')
local mainMenu6 = RageUI.CreateSubMenu(mainMenu5, 'Armurerie', 'Actions armurerie')
local mainMenu7 = RageUI.CreateSubMenu(mainMenu5, 'Armurerie', 'Actions armurerie')
mainMenu.Display.Header = true 
mainMenu.Closed = function()
  FreezeEntityPosition(PlayerPedId(), false)
  open = false
end

function OpenArmurerie()
    if open then 
        open = false
        RageUI.Visible(mainMenu, false)
        return
    else
        open = true 
        RageUI.Visible(mainMenu, true)
        VerifPPA()
        CreateThread(function()
            while open do
                if Config.PPAObligatoire == true then
                    if not possessionppa then
                        RageUI.IsVisible(mainMenu, function() 
                          
                            RageUI.Separator("↓ ~y~ Vous n'avez pas le PPA ~s~↓")

                            RageUI.Button("Liquide", nil, {RightLabel = "→"}, false , {
                            onSelected = function() 
                            end
                            })

                            RageUI.Button("Banque", nil, {RightLabel = "→"}, false , {
                            onSelected = function() 
                            end
                            })
                        end)
                    else
                        RageUI.IsVisible(mainMenu, function() 
                          
                            RageUI.Separator("↓ ~y~ Armurerie ~s~↓")

                            RageUI.Button("Liquide", nil, {RightLabel = "→"}, true , {
                            onSelected = function() 
                            end
                            }, mainMenu2)

                            RageUI.Button("Banque", nil, {RightLabel = "→"}, true , {
                            onSelected = function() 
                            end
                            }, mainMenu5)

                        end)
                    end
                else
                    RageUI.IsVisible(mainMenu, function() 
                          
                        RageUI.Separator("↓ ~y~ Armurerie ~s~↓")

                        RageUI.Button("Liquide", nil, {RightLabel = "→"}, true , {
                        onSelected = function() 
                        end
                        }, mainMenu2)

                        RageUI.Button("Banque", nil, {RightLabel = "→"}, true , {
                        onSelected = function() 
                        end
                        }, mainMenu5)

                    end)
                end

                RageUI.IsVisible(mainMenu2, function() 
  
                    RageUI.Separator("→ Mode de Paiement : ~y~Liquide ~s~ ←")

                    RageUI.Button("Armes Blanches", nil, {RightLabel = "→"}, true , {
                    onSelected = function() 
                    end
                    }, mainMenu3)

                    RageUI.Button("Armes à feu", nil, {RightLabel = "→"}, true , {
                    onSelected = function() 
                    end
                    }, mainMenu4)

                end)

                RageUI.IsVisible(mainMenu3, function() 

                    for k,v in pairs(Config.ArmesBlanche) do
                        RageUI.Button(v.Label, nil, {RightLabel = "~y~" ..v.Prix.. "$"}, true , {
                            onSelected = function()
                                Model = v.Model
                                Prix = v.Prix
                                TriggerServerEvent("pAmunation:achatliquide", Model, Prix)
                            end
                        })
                    end

                end)

                RageUI.IsVisible(mainMenu4, function() 

                    for k,v in pairs(Config.Armes) do
                        RageUI.Button(v.Label, nil, {RightLabel = "~y~" ..v.Prix.. "$"}, true , {
                            onSelected = function()
                                Model = v.Model
                                Prix = v.Prix
                                TriggerServerEvent("pAmunation:achatliquide", Model, Prix)
                            end
                        })
                    end

                end)

                RageUI.IsVisible(mainMenu5, function() 
                    
                    RageUI.Separator("→ Mode de Paiement : ~y~Banque ~s~ ←")

                    RageUI.Button("Armes Blanches", nil, {RightLabel = "→"}, true , {
                    onSelected = function() 
                    end
                    }, mainMenu6)

                    RageUI.Button("Armes à feu", nil, {RightLabel = "→"}, true , {
                    onSelected = function() 
                    end
                    }, mainMenu7)

                end)

                RageUI.IsVisible(mainMenu6, function() 

                    for k,v in pairs(Config.ArmesBlanche) do
                        RageUI.Button(v.Label, nil, {RightLabel = "~y~" ..v.Prix.. "$"}, true , {
                            onSelected = function()
                                Model = v.Model
                                Prix = v.Prix
                                TriggerServerEvent("pAmunation:achatbanque", Model, Prix)
                            end
                        })
                    end

                end)

                RageUI.IsVisible(mainMenu7, function() 

                    for k,v in pairs(Config.Armes) do
                        RageUI.Button(v.Label, nil, {RightLabel = "~y~" ..v.Prix.. "$"}, true , {
                            onSelected = function()
                                Model = v.Model
                                Prix = v.Prix
                                TriggerServerEvent("pAmunation:achatbanque", Model, Prix)
                            end
                        })
                    end

                end)

                Wait(0)
            end
        end)
    end
end
