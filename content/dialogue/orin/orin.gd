extends DialogueLogic


func logic(player: Player, panel: DialoguePanel) -> void:
	panel.start("Orin")
	await panel.display_text("Hello there!")
	await panel.display_text("It's quite peaceful out here, isn't it?")
	await panel.display_text("I never get lonely, though.")
	await panel.display_text("Plenty of stars to keep me company.")
	
	var n_sellable: int = player.inventory.get_n_sellable_total()
	var sellable_value: int = player.inventory.get_total_sellable_value()
	
	var i: int = await panel.display_options("What can I do for you?",
		["Sell %d ore for %d chips" % [n_sellable, sellable_value],
		 "Nevermind"])
	
	if i == 0:
		await panel.display_text("Pleasure doing business!")
	elif i == 1:
		await panel.display_text("Thanks for stopping by!")
	
	panel.finish()
