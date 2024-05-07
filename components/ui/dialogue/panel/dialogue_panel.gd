class_name DialoguePanel
extends PanelContainer


signal started
signal next_triggered
signal option_selected(i: int)
signal finished

const OPTION_SCENE: PackedScene = preload("res://components/ui/dialogue/option/dialogue_option.tscn")

@onready var text_label: Label = %TextLabel
@onready var name_container: PanelContainer = %NameContainer
@onready var name_label: Label = %NameLabel
@onready var option_container: VBoxContainer = %Options
@onready var visible_characters_tick: Timer = $VisibleCharactersTick


func _unhandled_input(event: InputEvent) -> void:
	if not visible or not event.is_action_pressed("interact"):
		return
	
	_next()
	get_viewport().set_input_as_handled()


func start(character_name: String = "") -> void:
	text_label.visible_characters = 0
	name_label.text = character_name
	name_container.visible = character_name.length() > 0
	show()
	started.emit()


func display_text(text: String) -> void:
	_clear_options()
	text_label.text = text
	text_label.visible_characters = 0
	visible_characters_tick.start()
	await next_triggered


func display_options(text: String, options: Array[String]) -> int:
	assert(options.size() > 0)
	_clear_options()
	text_label.text = text
	text_label.visible_characters = 0
	for option_i in options.size():
		var option_button: Button = OPTION_SCENE.instantiate()
		option_container.add_child(option_button)
		option_button.modulate = Color.TRANSPARENT
		option_button.text = options[option_i]
		option_button.pressed.connect(_on_option_button_selected.bind(option_i))
		
	visible_characters_tick.start()
	var i: int = await option_selected
	return i


func finish() -> void:
	finished.emit()
	hide()


func _next() -> void:
	if text_label.visible_characters < text_label.text.length():
		_fast_forward()
		return
	if option_container.get_child_count() > 0:
		_reveal_options()
		return
	
	next_triggered.emit()


func _fast_forward() -> void:
	text_label.visible_characters = text_label.text.length()


func _reveal_options() -> void:
	for option in option_container.get_children():
		option.modulate = Color.WHITE


func _clear_options() -> void:
	for option in option_container.get_children():
		option.queue_free()


func _on_visible_characters_tick_timeout() -> void:
	if text_label.visible_characters < 0:
		return
	
	text_label.visible_characters += 1
	if text_label.visible_characters >= text_label.text.length():
		visible_characters_tick.stop()
		_reveal_options()


func _on_option_button_selected(i: int) -> void:
	option_selected.emit(i)
