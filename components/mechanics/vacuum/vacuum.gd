class_name Vacuum
extends Area2D


signal body_reached_center(body: RigidBody2D)

@export var force: float = 400.0
@export var correction_force: float = 800.0

var affected_bodies: Array[RigidBody2D] = []

@onready var center_area: Area2D = $CenterArea


func _ready() -> void:
	center_area.collision_mask = collision_mask


func _physics_process(_delta: float) -> void:
	for body: RigidBody2D in affected_bodies:
		var direction: Vector2 = (global_position - body.global_position).normalized()
		body.apply_force(direction * force)
		
		var correction: Vector2 = direction - body.linear_velocity.normalized()
		body.apply_force(correction * correction_force)


func _on_body_entered(body: RigidBody2D) -> void:
	if body == null:
		return
	
	if not affected_bodies.has(body):
		affected_bodies.append(body)
		body.tree_exiting.connect(_on_body_tree_exiting.bind(body))


func _on_center_area_body_entered(body: RigidBody2D) -> void:
	if body == null:
		return
	
	if affected_bodies.has(body):
		body_reached_center.emit(body)


func _on_body_tree_exiting(body: RigidBody2D) -> void:
	affected_bodies.erase(body)
