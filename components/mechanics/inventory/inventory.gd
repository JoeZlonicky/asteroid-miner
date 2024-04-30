class_name Inventory
extends RefCounted


signal item_added(item_data: ItemData, n: int)

var items: Dictionary = {}


func add_item(item_data: ItemData, n: int = 1) -> void:
	assert(n > 0)
	items[item_data] = items.get(item_data, 0) + n
	item_added.emit(item_data, n)


func has_item(item_data: ItemData, min_n: int = 1) -> bool:
	assert(min_n > 0)
	return items.get(item_data, 0) >= min_n


func get_item_count(item_data: ItemData) -> int:
	return items[item_data]
