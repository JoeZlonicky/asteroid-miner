extends Sprite2D


const PROJECTILE_SCENE: PackedScene = preload("uid://bhpuqbiokova")

@export_flags_2d_physics var sight_mask: int
@export_flags_2d_physics var shoot_mask: int

var current_target: Node
var current_target_position: Vector2

var rotate_speed: float = 3.0
var sight_range: float = 1200.0

@onready var spawn_point: Marker2D = $SpawnPoint
@onready var cooldown_timer: Timer = $Cooldown


func _physics_process(delta: float) -> void:
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
	global_rotation = rotate_toward(global_rotation, target_rotation, rotate_speed * delta)
	
	if not cooldown_timer.is_stopped():
		return
	
	spawn_projectile(spawn_point.global_position)
	cooldown_timer.start()


func spawn_projectile(spawn_position: Vector2) -> void:
	var projectile: Projectile = PROJECTILE_SCENE.instantiate()
	get_tree().current_scene.add_child(projectile)
	projectile.fire(spawn_position, global_rotation - PI / 2.0)
