extends DialogueLogic


func logic(player: Player, panel: DialoguePanel) -> void:
	panel.start("Xatar")
	await panel.display_text("Nice ship ya got there!")
	await panel.display_text("Good, solid steel.")
	await panel.display_text("...")
	await panel.display_text("Try not to scratch it.")
	panel.finish()
