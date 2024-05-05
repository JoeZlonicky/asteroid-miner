class_name Player
extends RigidBody2D

var preoccupied: bool = false  # E.g. in dialogue
var inventory := Inventory.new()
var movement_controller := ShipMovementController.new()

@onready var turret: Turret = $Turret
@onready var left_trail: GPUParticles2D = $Thrusters/LeftTrail
@onready var right_trail: GPUParticles2D = $Thrusters/RightTrail


func _physics_process(delta: float) -> void:
	turret.is_active = not preoccupied
	if preoccupied:
		movement_controller.update(self, Vector2.UP, delta)  # Slow down
		return
	
	var input: Vector2 = Input.get_vector("ship_left", "ship_right", "ship_slow", "ship_forward")
	movement_controller.update(self, input, delta)
	
	var has_forward_thrust: bool = input.y > 0.0
	left_trail.emitting = has_forward_thrust or input.x > 0.0
	right_trail.emitting = has_forward_thrust or input.x < 0.0


func _on_pickup_vacuum_body_reached_center(pickup: Pickup) -> void:
	var item_data: ItemData = pickup.item_data
	inventory.add_item(item_data)
	pickup.queue_free()
