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
	return items.get(item_data, 0)


func get_stack_sell_value(item_data: ItemData) -> int:
	return get_item_count(item_data) * item_data.sell_value


func get_n_sellable_total() -> int:
	var n: int = 0
	for item_data: ItemData in items:
		if item_data.can_be_sold:
			n += get_item_count(item_data)
	return n


func get_total_sellable_value() -> int:
	var total: int = 0
	for item_data: ItemData in items:
		total += get_stack_sell_value(item_data)
	return total
