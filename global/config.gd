extends Node

const MIN_WINDOW_SIZE = Vector2(800, 600)


func _ready() -> void:
	DisplayServer.window_set_min_size(MIN_WINDOW_SIZE)
