extends DialogueLogic


func logic(_player: Player, panel: DialoguePanel) -> void:
	panel.start("Orin")
	await panel.display_text("Hello there!")
	await panel.display_text("It's quite peaceful out here, isn't it?")
	await panel.display_text("I never get lonely, though.")
	await panel.display_text("Plenty of stars to keep me company.")
	panel.finish()
