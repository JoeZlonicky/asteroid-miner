class_name Health
extends RefCounted


signal died
signal damaged(amount: int)

var max_value: int
var current: int
var is_dead: bool = false


func _init(p_max_value: int) -> void:
	max_value = p_max_value
	current = max_value


func take_damage(amount: int) -> void:
	assert(amount >= 0)
	
	if amount == 0 or is_dead:
		return
	
	var before: int = current
	current = max(current - amount, 0)
	
	damaged.emit(before - current)
	
	if current == 0:
		died.emit()
