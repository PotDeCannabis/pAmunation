ESX = nil

TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)

-- Liquide

RegisterNetEvent("pAmunation:achatliquide") 
AddEventHandler("pAmunation:achatliquide", function(Model, Prix) 
	local joueur = ESX.GetPlayerFromId(source)  
	local argent = joueur.getMoney()

	if argent >= Prix then 
		joueur.removeMoney(Prix) 

		joueur.addWeapon(Model, 1) 
		TriggerClientEvent('esx:showNotification', source, "Vous avez acheter un ~y~produit ~s~pour ~y~" ..Prix.. "$~s~.")
	else 
		TriggerClientEvent("esx:showNotification", source, "~r~Vous n'avez pas assez d'argent.")
	end
end)

-- Banque

RegisterNetEvent('pAmunation:achatbanque') 
AddEventHandler('pAmunation:achatbanque', function(Model, Prix)
	local joueur = ESX.GetPlayerFromId(source)  
	local argent = joueur.getAccount('bank').money

	if argent >= Prix then 
		joueur.removeAccountMoney('bank', Prix)

		joueur.addWeapon(Model, 1) 
		TriggerClientEvent('esx:showNotification', source, "Vous avez acheter un ~y~produit ~s~pour ~y~" ..Prix.. "$~s~.")
	else 
		TriggerClientEvent("esx:showNotification", source, "~r~Vous n'avez pas assez d'argent.")
	end
end)
