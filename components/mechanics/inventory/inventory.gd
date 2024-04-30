class_name Inventory
extends RefCounted


signal item_added(item_data: ItemData, n: int)

var _items: Dictionary = {}


func add_item(item_data: ItemData, n: int = 1) -> void:
	assert(n > 0)
	_items[item_data] = _items.get(item_data, 0) + n
	item_added.emit(item_data, n)


func has_item(item_data: ItemData, min_n: int = 1) -> bool:
	assert(min_n > 0)
	return _items.get(item_data, 0) >= min_n


func get_items() -> Array[ItemData]:
	var keys: Array[ItemData] = []
	keys.assign(_items.keys())
	return keys


func get_item_count(item_data: ItemData) -> int:
	return _items[item_data]
