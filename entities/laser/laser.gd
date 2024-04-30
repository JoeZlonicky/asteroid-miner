class_name Projectile
extends CharacterBody2D


const SPEED: float = 2400.0

@export var hit_explosion_scene: PackedScene

@onready var explosion_point: Node2D = $ExplosionPoint


func fire(g_position: Vector2, angle: float, bonus_speed: float = 0.0) -> void:
	global_position = g_position
	rotation = angle
	velocity = Vector2(cos(angle), sin(angle)) * (SPEED + bonus_speed)


func _physics_process(_delta: float) -> void:
	move_and_slide()


func _on_lifespan_timeout() -> void:
	queue_free()


func _on_hit_area_body_entered(body: Node2D) -> void:
	if body is Deposit:
		body.health.take_damage(1)
	if hit_explosion_scene:
		spawn_explosion.call_deferred()
		
	queue_free()


func spawn_explosion() -> void:
	var hit_explosion: Node2D = hit_explosion_scene.instantiate()
	get_tree().current_scene.add_child(hit_explosion)
	hit_explosion.global_position = explosion_point.global_position
