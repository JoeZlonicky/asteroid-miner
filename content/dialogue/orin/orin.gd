extends DialogueLogic


func logic(_player: Player, panel: DialoguePanel) -> void:
	panel.start("Orin")
	await panel.display_text("Hello there!")
	await panel.display_text("It's quite peaceful out here, isn't it?")
	await panel.display_text("I never get lonely, though.")
	await panel.display_text("Plenty of stars to keep me company.")
	
	var i: int = await panel.display_options("What can I do for you?",
		["Sell ore", "I'm good, thanks!"])
	
	if i == 0:
		await panel.display_text("I'll put it to good use!")
	elif i == 1:
		await panel.display_text("Thanks for stopping by!")
	
	panel.finish()
