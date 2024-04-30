class_name Pickup
extends RigidBody2D


const DEFAULT_DRIFT_SPEED: float = 100.0

@export var item_data: ItemData

@onready var sprite: Sprite2D = $Sprite2D


func _ready() -> void:
	var random_angle: float = randf_range(0, 2 * PI)
	apply_impulse(Vector2.from_angle(random_angle) * DEFAULT_DRIFT_SPEED)
	sprite.texture = item_data.sprite
