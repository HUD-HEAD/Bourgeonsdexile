extends Node

##How sensitive is mouse movement
var mouse_sensitivity = 1.0

func _ready() -> void:
	##Clicks on e.g. Area2Ds (Clickables) will only trigger on topmost item
	get_viewport().physics_object_picking_first_only = true
	get_viewport().physics_object_picking_sort = true

func show_mouse():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func hide_mouse():
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN

func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_pressed("exit"):
		get_tree().quit()
	
	if OS.has_feature("debug"):
		_debug_inputs(event)
	
#TESTING
var resource : Resource = ResourceLoader.load("res://components/utils/debug/debug_scene_list.tres")

func _debug_inputs(event : InputEvent) -> void :
	if event.is_action_pressed("debug_speed_up"):
		Engine.time_scale *= 2
		print_debug("Speed up x", Engine.time_scale)
	if event.is_action_pressed("debug_speed_down"):
		Engine.time_scale /= 2
		print_debug("Speed down x", Engine.time_scale)
		
	if Input.is_action_pressed("debug_enable_scene_switch"):
		if event is InputEventKey and event.pressed:
			#Number pressed (0..9)
			if event.keycode >= 48 && event.keycode <= 57:
				var idx = event.keycode - 48
				print_debug("Debug loading scene ", idx)
				if idx < resource.ordered_scene_list.size():
					SceneManager.goto_scene(resource.ordered_scene_list[idx])
