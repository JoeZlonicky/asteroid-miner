extends Node


var player_inventory: Inventory


func _ready() -> void:
	start()


func start() -> void:
	player_inventory = Inventory.new()


func end() -> void:
	player_inventory = null
