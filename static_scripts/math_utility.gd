class_name MathUtility


class RayIntersection:
	var collider: CollisionObject2D
	var pos: Vector2
	
	func _init(p_collider: Node, p_position: Vector2) -> void:
		collider = p_collider
		pos = p_position


static func circular_raycast(space_state: PhysicsDirectSpaceState2D, position: Vector2, 
		distance: float, collision_mask: int = 0xffffffff, n: int = 64) -> Array[RayIntersection]:
	
	var collisions: Array[RayIntersection] = []
	for i in n:
		var angle: float = i * 2.0 * PI / n
		var end: Vector2 = position + Vector2.from_angle(angle) * distance
		var query := PhysicsRayQueryParameters2D.create(position, end, collision_mask)
		var result: Dictionary = space_state.intersect_ray(query)
		if not result or not result.collider:
			continue
		
		collisions.append(RayIntersection.new(result.collider, result.position))
	
	return collisions
