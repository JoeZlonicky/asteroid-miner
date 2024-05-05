class_name DialoguePanel
extends PanelContainer


signal finished

var dialogue: DialogueData = null
var page_i: int = 0

@onready var text_label: Label = %TextLabel
@onready var name_container: PanelContainer = %NameContainer
@onready var name_label: Label = %NameLabel
@onready var visible_characters_tick: Timer = $VisibleCharactersTick


func _unhandled_input(event: InputEvent) -> void:
	if not visible or not event.is_action_pressed("interact"):
		return
	
	next()
	get_viewport().set_input_as_handled()


func start(new_dialogue: DialogueData) -> void:
	if dialogue == new_dialogue:
		return
	
	dialogue = new_dialogue
	page_i = -1
	new_page()
	
	name_label.text = dialogue.character_name
	name_container.visible = name_label.text.length() > 0
	show()


func next() -> void:
	if text_label.visible_characters < text_label.text.length():
		text_label.visible_characters = text_label.text.length()
		return
	
	if page_i == dialogue.text.size() - 1:
		dialogue = null
		hide()
		finished.emit()
		return
	
	new_page()


func new_page() -> void:
	page_i += 1
	text_label.text = dialogue.text[page_i]
	text_label.visible_characters = 0
	visible_characters_tick.start()


func _on_visible_characters_tick_timeout() -> void:
	if text_label.visible_characters < 0:
		return
	
	text_label.visible_characters += 1
	if text_label.visible_characters >= text_label.text.length():
		visible_characters_tick.stop()
