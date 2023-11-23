local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "jm_accountant")

lib.locale()

RegisterServerEvent('vRP:Server:Rankcheck')
AddEventHandler('vRP:Server:Rankcheck', function()
    local src = source
    local user_id = vRP.getUserId({src})
    if user_id ~= nil then
        if vRP.hasPermission({user_id,Config.Permission}) then
            TriggerEvent('Context:Server:open', src)
		else
          TriggerClientEvent('ox_lib:notify', source, {type = 'error', title = locale('Name'), description = locale('permission')})
        end
    end
end)

RegisterNetEvent('Context:Server:open')
AddEventHandler('Context:Server:open', function(source)
    TriggerClientEvent('Context',source)
end)

RegisterServerEvent('Discord')
AddEventHandler('Discord', function(Name, Money, Procent, time, Verify)
    local date = os.date('%Y-%m-%d %H:%M:%S')
    if Config.Debug then
      print(date)
    end
  local user_id = vRP.getUserId({source})

	PerformHttpRequest(Discord.Webhook, function(err, text, headers) end, 'POST', json.encode(
    {
        username = "Justme1108",
        embeds = {
            {              
              title = locale('Name');
              description = locale('Discord-Log').." **"..Name.."** \n "..locale('Discord-Log2').." **"..Money.." "..locale('Discord-Log3').."** \n "..locale('Discord-Log4').." **"..Procent.."%** \n "..locale('Discord-Log5').." **"..date.."**. \n \n ----------------------- \n "..locale('Discord-Log6').." \n ----------------------- \n id : **"..user_id.."**";
              color = 359935;
              footer = {
                text = "Made by justme1108";
              }
            }
        }
    }), { ['Content-Type'] = 'application/json' })
end)

RegisterServerEvent('vRP:Server:launder')
AddEventHandler('vRP:Server:launder', function(Money, Procent)
  local user_id = vRP.getUserId({source})
  local money = Money * Procent / 100

  if Config.Debug then
    TriggerClientEvent('ox_lib:notify', source, {type = 'inform', description = 'Debug : '..Money..''})
  end

    if vRP.tryGetInventoryItem({user_id, Config.item, Money, true}) then
      vRP.giveMoney({user_id,money})
      TriggerClientEvent('ox_lib:notify', source, {type = 'success', description = locale('recive')..' '..Money..' '..locale('recive2').. ' '..money..' '..locale('recive3')})

        if Config.Debug then
          print(money)
        end
    end
end)