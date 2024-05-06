class_name DialogueLogic
extends RefCounted


func logic(_player: Player, panel: DialoguePanel) -> void:
	panel.start("Placeholder")
	await panel.display_text("Placeholder")
	panel.finish()
