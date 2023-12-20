class_name Asteroid
extends AnimatableBody2D

const ORE_SCENE: PackedScene = preload("res://pickup/ore/ore.tscn")

const N_ORE_DROPPED = 5
const MAX_HEALTH: int = 3

var current_health: int = MAX_HEALTH

@onready var animation_player: AnimationPlayer = $AnimationPlayer


func take_damage(amount: int = 1):
	current_health = max(current_health - amount, 0)
	if current_health == 0:
		for i in N_ORE_DROPPED:
			var ore = ORE_SCENE.instantiate()
			get_parent().call_deferred("add_child", ore)
			ore.global_position = global_position
		
		queue_free()
	else:
		animation_player.play("flash")
