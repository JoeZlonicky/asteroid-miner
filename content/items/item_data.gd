class_name ItemData
extends Resource


@export var name: String
@export var sprite: Texture
@export var can_be_sold: bool = true
@export_range(0, 999, 1) var sell_value: int = 1
