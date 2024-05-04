class_name GeneralHUD
extends CanvasLayer


@export var player: Player = null

@onready var notification_container: NotificationContainer = %NotificationContainer
@onready var inventory_panel: InventoryPanel = $InventoryPanel
@onready var speed_label: SpeedLabel = $SpeedLabel


func _ready() -> void:
	if player == null:
		return
	
	inventory_panel.set_inventory(player.inventory)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("inventory"):
		inventory_panel.visible = not inventory_panel.visible


func _physics_process(_delta: float) -> void:
	if player == null:
		return
	
	speed_label.update_text(player.linear_velocity.length())
