class_name Deposit
extends StaticBody2D


const PICKUP_SCENE: PackedScene = preload("res://entities/pickup/pickup.tscn")

@export var data: DepositData

var health := Health.new(5)
var is_shiny: bool = false

@onready var sprite: Sprite2D = $Sprite2D
@onready var collision_polygon: CollisionPolygon2D = $CollisionPolygon2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	health.damaged.connect(_on_health_damaged)
	health.died.connect(_on_health_died)
	
	if data == null:
		return
	
	sprite.texture = data.sprite
	collision_polygon.polygon = data.collision
	is_shiny = randf() < data.gem_chance


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("debug"):
		health.take_damage(1)


func _on_health_damaged(_amount: int) -> void:
	animation_player.play("flash")


func _on_health_died() -> void:
	if is_shiny and data.gem_drop:
		for i in data.n_gem_drops:
			spawn_pickup.call_deferred(data.gem_drop)
	elif not is_shiny and data.ore_drop:
		for i in data.n_ore_drops:
			spawn_pickup.call_deferred(data.ore_drop)
	
	queue_free()


func spawn_pickup(item_data: ItemData) -> void:
	var current_scene: Node = get_tree().current_scene
	var pickup: Pickup = PICKUP_SCENE.instantiate()
	pickup.item_data = item_data
	current_scene.add_child(pickup)
	pickup.global_position = global_position
