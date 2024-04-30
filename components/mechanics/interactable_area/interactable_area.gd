class_name InteractableArea
extends Area2D


signal interacted_with

@export var toggle_visibility: CanvasItem

var is_player_inside: bool = false


func _ready() -> void:
	if toggle_visibility != null:
		toggle_visibility.hide()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and is_player_inside:
		interacted_with.emit()


func _on_body_entered(_body: Node2D) -> void:
	is_player_inside = true
	if toggle_visibility != null:
		toggle_visibility.show()


func _on_body_exited(_body: Node2D) -> void:
	is_player_inside = false
	if toggle_visibility != null:
		toggle_visibility.hide()
