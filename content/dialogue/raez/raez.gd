extends DialogueLogic


func logic(_player: Player, panel: DialoguePanel) -> void:
	panel.start("Raez")
	await panel.display_text("Get your ore cookies here!")
	await panel.display_text("No, of course they don't have actual ore in them.")
	await panel.display_text("Well, not intentionally at least.")
	await panel.display_text("That stuff gets everywhere...")
	panel.finish()
