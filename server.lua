ESX.RegisterCommand(Config.UnitSpeed['commandName'], {'user','admin'}, function(xPlayer, args, showError)
    xPlayer.triggerEvent('fh4speed:setUnitSpeed', args.unitspeed)
    end, true, { help = 'fh4speed set unit speed display', validate = true, arguments = { 
       {name = 'unitspeed', help = 'unit speed KPH, MPH **can type lowercase', type = 'string'} 
}})

ESX.RegisterCommand(Config.ToggleHUD['commandName'], {'user','admin'}, function(xPlayer, args, showError)
    xPlayer.triggerEvent('fh4speed:toggleHUD')
    end, true, { help = 'fh4speed toggle HUD' })
