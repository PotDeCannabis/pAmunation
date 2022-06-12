ESX = nil

TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)

-- Liquide

RegisterNetEvent('pAmunation:achatLiquideKnife') 
AddEventHandler('pAmunation:achatLiquideKnife', function() 
	local joueur = ESX.GetPlayerFromId(source)  
	local argent = joueur.getMoney()

	-- Configuration:
	local prix = 50
	local items = 'weapon_knife'
	local nombre = 1

	if argent >= prix then 
		joueur.removeMoney(prix) 
		joueur.addWeapon(items, nombre) 
		TriggerClientEvent('esx:showNotification', source, "Vous avez acheter ~y~x" ..nombre.. " Knife~s~ pour ~y~" ..prix.. "$~s~.")
	else 
		TriggerClientEvent('esx:showNotification', source, "~r~Vous n'avez pas assez d'argent.")
	end
end)

RegisterNetEvent('pAmunation:achatLiquideMachette') 
AddEventHandler('pAmunation:achatLiquideMachette', function() 
	local joueur = ESX.GetPlayerFromId(source)  
	local argent = joueur.getMoney()

	-- Configuration:
	local prix = 35
	local items = 'weapon_machete'
	local nombre = 1

	if argent >= prix then 
		joueur.removeMoney(prix) 
		joueur.addWeapon(items, nombre) 
		TriggerClientEvent('esx:showNotification', source, "Vous avez acheter ~y~x" ..nombre.. " Machette~s~ pour ~y~" ..prix.. "$~s~.")
	else 
		TriggerClientEvent('esx:showNotification', source, "~r~Vous n'avez pas assez d'argent.")
	end
end)

RegisterNetEvent('pAmunation:achatLiquidePistoletCombat') 
AddEventHandler('pAmunation:achatLiquidePistoletCombat', function() 
	local joueur = ESX.GetPlayerFromId(source)  
	local argent = joueur.getMoney()

	-- Configuration:
	local prix = 1200
	local items = 'weapon_combatpistol'
	local nombre = 1

	if argent >= prix then 
		joueur.removeMoney(prix) 
		joueur.addWeapon(items, nombre) 
		TriggerClientEvent('esx:showNotification', source, "Vous avez acheter ~y~x" ..nombre.. " Pistolet de Combat~s~ pour ~y~" ..prix.. "$~s~.")
	else 
		TriggerClientEvent('esx:showNotification', source, "~r~Vous n'avez pas assez d'argent.")
	end
end)

RegisterNetEvent('pAmunation:achatLiquidePistoletSNS') 
AddEventHandler('pAmunation:achatLiquidePistoletSNS', function() 
	local joueur = ESX.GetPlayerFromId(source)  
	local argent = joueur.getMoney()

	-- Configuration:
	local prix = 800
	local items = 'weapon_snspistol'
	local nombre = 1

	if argent >= prix then 
		joueur.removeMoney(prix) 
		joueur.addWeapon(items, nombre) 
		TriggerClientEvent('esx:showNotification', source, "Vous avez acheter ~y~x" ..nombre.. " Pistolet SNS~s~ pour ~y~" ..prix.. "$~s~.")
	else 
		TriggerClientEvent('esx:showNotification', source, "~r~Vous n'avez pas assez d'argent.")
	end
end)

-- Banque

RegisterNetEvent('pAmunation:achatBanqueKnife') 
AddEventHandler('pAmunation:achatBanqueKnife', function() 
	local joueur = ESX.GetPlayerFromId(source)  
	local argent = joueur.getAccount('bank').money

	-- Configuration:
	local prix = 50
	local items = 'weapon_knife'
	local nombre = 1

	if argent >= prix then 
		joueur.removeAccountMoney('bank', prix)
		joueur.addWeapon(items, nombre) 
		TriggerClientEvent('esx:showNotification', source, "Vous avez acheter ~y~x" ..nombre.. " Knife~s~ pour ~y~" ..prix.. "$~s~.")
	else 
		TriggerClientEvent('esx:showNotification', source, "~r~Vous n'avez pas assez d'argent.")
	end
end)

RegisterNetEvent('pAmunation:achatBanqueMachette') 
AddEventHandler('pAmunation:achatBanqueMachette', function() 
	local joueur = ESX.GetPlayerFromId(source)  
	local argent = joueur.getAccount('bank').money

	-- Configuration:
	local prix = 35
	local items = 'weapon_machete'
	local nombre = 1

	if argent >= prix then 
		joueur.removeAccountMoney('bank', prix)
		joueur.addWeapon(items, nombre) 
		TriggerClientEvent('esx:showNotification', source, "Vous avez acheter ~y~x" ..nombre.. " Machette~s~ pour ~y~" ..prix.. "$~s~.")
	else 
		TriggerClientEvent('esx:showNotification', source, "~r~Vous n'avez pas assez d'argent.")
	end
 end)

RegisterNetEvent('pAmunation:achatBanquePistolet') 
AddEventHandler('pAmunation:achatBanquePistolet', function() 
	local joueur = ESX.GetPlayerFromId(source)  
	local argent = joueur.getAccount('bank').money

	-- Configuration:
	local prix = 1200
	local items = 'weapon_pistol'
	local nombre = 1

	if argent >= prix then 
		joueur.removeAccountMoney('bank', prix)
		joueur.addWeapon(items, nombre) 
		TriggerClientEvent('esx:showNotification', source, "Vous avez acheter ~y~x" ..nombre.. " Pistolet~s~ pour ~y~" ..prix.. "$~s~.")
	else 
		TriggerClientEvent('esx:showNotification', source, "~r~Vous n'avez pas assez d'argent.")
	end
 end)

RegisterNetEvent('pAmunation:achatBanquePistoletSNS') 
AddEventHandler('pAmunation:achatBanquePistoletSNS', function() 
	local joueur = ESX.GetPlayerFromId(source)  
	local argent = joueur.getAccount('bank').money

	-- Configuration:
	local prix = 800
	local items = 'weapon_snspistol'
	local nombre = 1

	if argent >= prix then 
		joueur.removeAccountMoney('bank', prix)
		joueur.addWeapon(items, nombre) 
		TriggerClientEvent('esx:showNotification', source, "Vous avez acheter ~y~x" ..nombre.. " Pistolet SNS~s~ pour ~y~" ..prix.. "$~s~.")
	else 
		TriggerClientEvent('esx:showNotification', source, "~r~Vous n'avez pas assez d'argent.")
	end
 end)