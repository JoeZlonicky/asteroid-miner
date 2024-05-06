class_name DialoguePanel
extends PanelContainer


signal started
signal next_triggered
signal finished

@onready var text_label: Label = %TextLabel
@onready var name_container: PanelContainer = %NameContainer
@onready var name_label: Label = %NameLabel
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
	text_label.text = text
	text_label.visible_characters = 0
	visible_characters_tick.start()
	await next_triggered


func finish() -> void:
	finished.emit()
	hide()


func _next() -> void:
	if text_label.visible_characters < text_label.text.length():
		text_label.visible_characters = text_label.text.length()
		return
	
	next_triggered.emit()


func _on_visible_characters_tick_timeout() -> void:
	if text_label.visible_characters < 0:
		return
	
	text_label.visible_characters += 1
	if text_label.visible_characters >= text_label.text.length():
		visible_characters_tick.stop()
