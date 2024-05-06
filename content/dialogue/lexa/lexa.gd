extends DialogueLogic


func logic(_player: Player, panel: DialoguePanel) -> void:
	panel.start("Lexa")
	await panel.display_text("New to the field?")
	await panel.display_text("It's a fascinating place...")
	await panel.display_text("When ZX-792 and GR-7 collided, this fast field of rock and minerals was created.")
	await panel.display_text("Let me know what you find!")
	panel.finish()
