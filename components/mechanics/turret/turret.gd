class_name Turret
extends Sprite2D


const EXPLOSION_SCENE: PackedScene = preload("uid://cysq5jcic27uu")

@export_flags_2d_physics var sight_mask: int
@export_flags_2d_physics var shoot_mask: int

var is_active: bool = false

var current_target: Node
var current_target_position: Vector2

var independent_rotation: float = 0.0
var rotate_speed: float = 3.0
var sight_range: float = 800.0
var allowed_angle_difference_to_hit: float = 0.001

@onready var end_point: Marker2D = $EndPoint
@onready var cooldown_timer: Timer = $CooldownTimer
@onready var laser: Line2D = $Laser


func _ready() -> void:
	independent_rotation = global_rotation


func _physics_process(delta: float) -> void:
	global_rotation = independent_rotation
	
	laser.hide()
	if not is_active:
		return
	
	var space_state: PhysicsDirectSpaceState2D = get_world_2d().direct_space_state
	var intersections: Array[MathUtility.RayIntersection] = MathUtility.circular_raycast(space_state,
		global_position, sight_range, sight_mask)
	
	var nearest_target: Node = null
	var nearest_position: Vector2 = Vector2.INF
	var nearest_distance: float = INF
	var current_target_still_in_sight: bool = false
	
	for intersection in intersections:
		if not (intersection.collider.collision_layer & shoot_mask):
			continue
		
		if current_target and intersection.collider == current_target:
			current_target_still_in_sight = true
			break
		
		var d: float = (intersection.pos - global_position).length()
		if d >= nearest_distance:
			continue
		
		nearest_target = intersection.collider
		nearest_position = intersection.pos
		nearest_distance = d
	
	if not current_target_still_in_sight:
		current_target = nearest_target
		current_target_position = nearest_position
	
	if not current_target:
		return
	
	var target_rotation: float = (current_target_position - global_position).angle() + PI / 2.0
	independent_rotation = rotate_toward(independent_rotation, target_rotation, rotate_speed * delta)
	
	var angle_diff: float = angle_difference(target_rotation, independent_rotation)
	if abs(angle_diff) > allowed_angle_difference_to_hit:
		return
	
	laser.points[0] = end_point.position
	var distance_to_target: float = (current_target_position - end_point.global_position).length()
	laser.points[1] = end_point.position + Vector2.UP * distance_to_target
	laser.show()
	
	if not cooldown_timer.is_stopped():
		return
	
	var deposit := current_target as Deposit
	deposit.health.take_damage(1)
	
	var hit_explosion: Node2D = EXPLOSION_SCENE.instantiate()
	get_tree().current_scene.add_child(hit_explosion)
	hit_explosion.global_position = current_target_position
	
	cooldown_timer.start()
