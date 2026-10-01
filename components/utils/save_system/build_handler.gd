class_name BuildTypeHandler
extends Node

enum build_mode
{
	normal_mode,
	museum_mode,
}

enum chapter_to_enable
{
	chapter_1 = 0,
	chapter_2 = 1,
	chapter_3 = 2,
}

@export var build_type: build_mode
@export var chapter_idx: chapter_to_enable

@export_group("config")
@export var chapter_pictures : Array[Node2D]
@export var chapter_buttons : Array[BaseButton]

func _enter_tree() -> void:
	if build_type == build_mode.museum_mode:
		SaveManager.all_chapters_unlock_museum_build_type = true
		SaveManager.chapter_enable_museum_build_type = chapter_idx
	else:
		SaveManager.all_chapters_unlock_museum_build_type = false

func _ready() -> void:
	if build_type == build_mode.museum_mode:
		_hide_backgrounds()
		_show_chapter_to_enable()
		SaveManager.all_chapters_unlock_museum_build_type = true
		SaveManager.chapter_enable_museum_build_type = chapter_idx
	else:
		SaveManager.all_chapters_unlock_museum_build_type = false


func _hide_backgrounds():
	for backGround: Node2D in chapter_pictures:
		get_tree().create_tween().tween_property(backGround, "modulate", Color(Color.WHITE, 0), 0.1)
	
	for button_idx: int in chapter_buttons.size():
		get_tree().create_tween().tween_property(chapter_buttons[button_idx], "modulate", Color(Color.WHITE, 0), 0.1)
		chapter_buttons[button_idx].visible = false
		chapter_buttons[button_idx].disabled = true
		

func _show_chapter_to_enable():
	get_tree().create_tween().tween_property(chapter_pictures[chapter_idx], "modulate", Color(Color.WHITE, 1), 0.1)
	get_tree().create_tween().tween_property(chapter_buttons[chapter_idx], "modulate", Color(Color.WHITE, 1), 0.1)
	chapter_buttons[chapter_idx].visible = true
	chapter_buttons[chapter_idx].disabled = false
