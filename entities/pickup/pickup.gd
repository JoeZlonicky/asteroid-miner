class_name Pickup
extends CharacterBody2D


const DEFAULT_DRIFT_SPEED: float = 20.0

@export var item_data: ItemData

@onready var sprite: Sprite2D = $Sprite2D


func _ready() -> void:
	var random_angle: float = randf_range(0, 2 * PI)
	velocity = Vector2.from_angle(random_angle) * DEFAULT_DRIFT_SPEED
	sprite.texture = item_data.sprite


func _physics_process(_delta: float) -> void:
	move_and_slide()
