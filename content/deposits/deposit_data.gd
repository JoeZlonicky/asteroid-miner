class_name DepositData
extends Resource

@export var sprite: Texture2D
@export var collision: PackedVector2Array

@export_category("Drops")
@export_range(0.0, 1.0) var gem_chance: float = 0.1
@export var ore_drop: ItemData
@export var gem_drop: ItemData
@export var n_ore_drops: int = 5
@export var n_gem_drops: int = 1
