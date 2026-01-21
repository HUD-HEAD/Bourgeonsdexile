extends Node

@export var chapter_pictures : Array[Node2D]
@export var chapter_buttons : Array[BaseButton]


var idx : int = 0

func _ready() -> void:
	for i in chapter_buttons.size():
		chapter_buttons[i].mouse_entered.connect(_transition_to.bind(i))
		_update_button_visuals()

func _transition_to(chapter : int):
	if chapter >= chapter_pictures.size():
		printerr("idx outside available chapters")
		return
	
	get_tree().create_tween().tween_property(chapter_pictures[idx], "modulate", Color(Color.WHITE, 0), 1.0)
	get_tree().create_tween().tween_property(chapter_pictures[chapter], "modulate", Color(Color.WHITE, 1), 1.0)
	idx = chapter
	
	_update_button_visuals()

func _update_button_visuals():
	for i in chapter_buttons.size():
		chapter_buttons[i].self_modulate.a = 1.0 if i == idx else 0.5
