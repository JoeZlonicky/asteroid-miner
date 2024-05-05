class_name InteractableArea
extends Area2D


signal interacted_with

@export var toggle_visibility: CanvasItem

var player_inside: Player = null


func _ready() -> void:
	if toggle_visibility != null:
		toggle_visibility.hide()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and player_inside and not player_inside.preoccupied:
		interacted_with.emit()


func _on_body_entered(player: Player) -> void:
	if not player:
		return
	
	player_inside = player
	if toggle_visibility != null:
		toggle_visibility.show()


func _on_body_exited(player: Player) -> void:
	if not player:
		return
	
	player_inside = null
	if toggle_visibility != null:
		toggle_visibility.hide()
