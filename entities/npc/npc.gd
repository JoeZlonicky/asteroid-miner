class_name NPC
extends Node2D

@export var dialogue_panel: DialoguePanel = null
@export var dialogue_script: GDScript = null
@export var player: Player = null

var _dialogue: DialogueLogic = null


func _ready() -> void:
	_dialogue = dialogue_script.new()


func _on_interactable_area_interacted_with() -> void:
	_dialogue.logic(player, dialogue_panel)
