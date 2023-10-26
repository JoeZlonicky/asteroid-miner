extends Area2D


const SPEED: float = 600.0

var velocity: Vector2


func fire(g_position: Vector2, angle: float, bonus_speed: float = 0.0) -> void:
	global_position = g_position
	rotation = angle
	velocity = Vector2(cos(angle), sin(angle)) * (SPEED + bonus_speed)


func _physics_process(delta: float) -> void:
	position += velocity * delta


func _on_lifespan_timeout() -> void:
	queue_free()
