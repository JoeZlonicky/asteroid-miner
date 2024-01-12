class_name OctagonalControllerComponent
extends Node2D


var move_speed: float = 650.0
var rotation_speed: float = 10.0

var last_input_direction: Vector2 = Vector2.ZERO

@onready var character: CharacterBody2D = owner


func _physics_process(delta: float) -> void:
	if character == null:
		return
	
	var horizontal_input: float = Input.get_axis("move_left", "move_right")
	var vertical_input: float = Input.get_axis("move_up", "move_down")
	var input := Vector2(horizontal_input, vertical_input)
	
	process_velocity(input, delta)
	process_rotation(input, delta)


func process_velocity(input_vector: Vector2, _delta: float) -> void:
	if input_vector:
		character.velocity = input_vector.normalized() * move_speed
	else:
		character.velocity = Vector2.ZERO
	character.move_and_slide()


func process_rotation(input_vector: Vector2, delta: float) -> void:
	if input_vector:
		last_input_direction = input_vector.normalized()
	
	if not last_input_direction:
		return
	
	character.rotation = rotate_toward(character.rotation, last_input_direction.angle() + PI / 2.0,
		rotation_speed * delta)
