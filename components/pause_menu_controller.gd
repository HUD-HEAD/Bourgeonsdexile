extends Node

@export var pause_menu_scene: PackedScene = preload("res://scenes/menus/pause_menu.tscn")

@export var pause_menu: Control

@export var resume_button: Button
@export var settings_button: Button
@export var main_menu_button: Button
@export var canvas_layer: CanvasLayer

var is_active: bool
var settings_enabled: bool = false

func _ready() -> void:
	process_mode = PROCESS_MODE_ALWAYS
	
	canvas_layer = CanvasLayer.new()
	canvas_layer.name = "Canvas"
	add_child(canvas_layer)
	
	pause_menu = pause_menu_scene.instantiate()
	canvas_layer.add_child(pause_menu)
	
	#resume_button = $PauseMenu/Canvas/Resume_Button
	#settings_button = $PauseMenu/Canvas/Settings_Button
	#main_menu_button = $PauseMenu/Canvas/MainMenu_Button
	#canvas_layer = $PauseMenu/Canvas

	resume_button = $Canvas/PauseMenu/Resume_Button
	settings_button = $Canvas/PauseMenu/Settings_Button
	main_menu_button = $Canvas/PauseMenu/MainMenu_Button


	
	resume_button.pressed.connect(on_press_resume)
	settings_button.pressed.connect(on_press_settings)
	main_menu_button.pressed.connect(on_press_main_menu)
	
	hide_menu()
	pause_menu.visible = false
	is_active = false

func show_pause_menu():
	if !get_tree().root.has_node("MainMenu"):
		if !is_active:
			is_active = true
			show_menu()
			pause_menu.visible = true
			get_tree().paused = true
		else:
			if settings_enabled:
				settings_enabled = false
				SceneManager.close_settings()
			else:
				on_press_resume()

func on_press_resume():
	is_active = false
	hide_menu()
	get_tree().paused = false

func on_press_settings():
	settings_enabled = true
	SceneManager.open_settings()

func on_press_main_menu():
	AudioManager.reset_audio()
	on_press_resume()
	SceneManager.goto_scene(ProjectSettings.get_setting("application/run/main_scene"))

const TRANSITION_TIME = 0.2

func show_menu():
	pause_menu.modulate.a = 0
	var tween = create_tween()
	tween.tween_property(pause_menu, "modulate:a", 1.0, TRANSITION_TIME)
	
	await get_tree().create_timer(TRANSITION_TIME).timeout
	pause_menu.modulate.a = 1

func hide_menu():
	var tween = create_tween()
	tween.tween_property(pause_menu, "modulate:a", 0.0, TRANSITION_TIME)
	
	#wait TRANSITION_TIME to disable pause menu
	await get_tree().create_timer(TRANSITION_TIME).timeout
	pause_menu.visible = false
