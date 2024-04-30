class_name InventoryPanel
extends NinePatchRect


var inventory: Inventory = null

@onready var grid_container: GridContainer = %GridContainer


func _on_visibility_changed() -> void:
	if not visible or not inventory:
		return
	
	refresh()


func refresh() -> void:
	var i: int = 0
	for item: ItemData in inventory.get_items():
		var slot: InventorySlot = grid_container.get_child(i)
		slot.item_sprite.texture = item.sprite
		slot.count_label.text = str(inventory.get_item_count(item))
		i += 1
	
	for k in range(i, grid_container.get_child_count()):
		var slot: InventorySlot = grid_container.get_child(k)
		slot.count_label.text = ""
		slot.item_sprite.texture = null
