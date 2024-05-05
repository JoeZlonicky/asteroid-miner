class_name NPC
extends Node2D

signal dialogue_started(data: DialogueData)

@export var dialogue_data: DialogueData


func _on_interactable_area_interacted_with() -> void:
	dialogue_started.emit(dialogue_data)
