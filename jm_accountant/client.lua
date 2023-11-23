vRP = Proxy.getInterface("vRP") 
vRPclient = Tunnel.getInterface("vRP", "jm_accountant")

lib.locale()
-------------------------------------------------------------------
-------------------------------------------------------------------
-------------------------------------------------------------------
if Discord.Webhook == 'https://discord.com/api/webhooks/' then
	print(locale('missing-Webhook'))
	print(locale('missing-Webhook'))
	print(locale('missing-Webhook'))
	print(locale('missing-Webhook'))
	print(locale('missing-Webhook'))
end
-------------------------------------------------------------------
-------------------------------------------------------------------
-------------------------------------------------------------------
if Config.Select == 'Target' then
	exports.ox_target:addSphereZone({
	coords = vec3(-138.3949, -633.3613, 168.7313),
	radius = 0.5,
	debug = Config.Debug,
	options = {
	{
		name = 'sphere',
--		event = 'Context',
		event = 'vRP:Client:RankCheck',
		icon = 'fa-solid fa-briefcase',
		label = locale('open-target'),
	}
	}
	})
end

RegisterNetEvent('vRP:Client:RankCheck')
AddEventHandler('vRP:Client:RankCheck', function()
	TriggerServerEvent('vRP:Server:RankCheck')
end)

if Config.Select == 'TextUI' then
	for k, v in pairs(Config.Revisor) do

		local point = lib.points.new(v, 2, {})
	
		function point:onEnter()
			lib.showTextUI(locale('open-menu-TextUI'), {position = "right-center", icon = 'fa-solid fa-briefcase',})
		end
	
		function point:onExit() lib.hideTextUI() end
	
		function point:nearby()
			if self.currentDistance < 3 then
			end
	
			if self.currentDistance < 2 and IsControlJustReleased(0, 38) then
				TriggerServerEvent('vRP:Server:Rankcheck')
			end
		end
	end
end
-------------------------------------------------------------------
-------------------------------------------------------------------
-------------------------------------------------------------------
lib.registerContext({
	id = 'Revisor',
	title = locale('context-title'),
	options = {
	  {
		title = locale('context-undertitle'),
	  },
	  {
		title = locale('context-option'),
		description = locale('context-option-description'),
		icon = 'fa-solid fa-sack-dollar',
		onSelect = function()
		TriggerEvent('input')
		end,
	  }
	}
  })

RegisterNetEvent('Context')
AddEventHandler('Context', function()
	lib.showContext('Revisor')
end)
RegisterNetEvent('input')
AddEventHandler('input', function()
	for k, v in pairs(Config.Abuse) do
		local input = lib.inputDialog(locale('question-label'), {
			{type = 'number', label = locale('question1'), description = locale('question1-description'), required = true},
			{type = 'number', label = locale('question2'), description = locale('question2-description')..' '..v.Max..'%', required = true, min = 1, max = v.Max},
			{type = 'checkbox', label = locale('question3'), required = true},
			{type = 'date', label = locale('question4'), default = true, format = "DD/MM/YYYY", required = true},
			{type = 'input', label = locale('question5'), description = locale('question5-description'), required = true},
		})
		
		if not input then 
			lib.notify({
				title = locale('Name'),
				description = locale('close'),
				type = 'error'
			})
		return end

		local Name = input[5]
		local Money = input[1]
		local Procent = input[2]
		TriggerServerEvent('Discord', Name, Money, Procent, Verify)
			if lib.progressBar({
				duration = Config.ProgressbarTimer * 1000,
				label = locale('wait')..' '..Money..''..locale('recive3'),
				useWhileDead = false,
				canCancel = true,
				disable = {
					move = true,
					car = true,
				}
			}) then TriggerServerEvent('vRP:Server:launder', Money, Procent) else 
				lib.notify({
				title = locale('Name'),
				description = locale('close'),
				type = 'error'})
			end


		if Config.Debug then
			print(input[1], input[2], input[3], input[4], input[5])
		end
	end
end)
-------------------------------------------------------------------
-------------------------------------------------------------------
-------------------------------------------------------------------
if Config.Debug then 
	RegisterCommand('Revisor:Debug', function()
		lib.showContext('Revisor')
	end)
	
	RegisterCommand('UI', function()
		lib.hideTextUI()
	end)
end