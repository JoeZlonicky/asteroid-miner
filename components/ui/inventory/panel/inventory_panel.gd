class_name InventoryPanel
extends Control

var _inventory: Inventory = null

@onready var grid_container: GridContainer = %GridContainer


func set_inventory(new_inventory: Inventory) -> void:
	if new_inventory == _inventory:
		return
	
	if _inventory != null:
		_inventory.item_added.disconnect(_on_inventory_item_added)
	
	_inventory = new_inventory
	_inventory.item_added.connect(_on_inventory_item_added)


func refresh() -> void:
	var i: int = 0
	var items: Dictionary = _inventory.items if _inventory != null else {}
	for item: ItemData in items:
		var slot: InventorySlot = grid_container.get_child(i)
		slot.item_sprite.texture = item.sprite
		slot.count_label.text = str(_inventory.get_item_count(item))
		i += 1
	
	for k in range(i, grid_container.get_child_count()):
		var slot: InventorySlot = grid_container.get_child(k)
		slot.count_label.text = ""
		slot.item_sprite.texture = null


func _on_visibility_changed() -> void:
	if not visible:
		return
	
	if not is_node_ready():
		await ready
	refresh()


func _on_inventory_item_added(_item_data: ItemData, _n: int) -> void:
	if not visible:
		return
	
	refresh()
