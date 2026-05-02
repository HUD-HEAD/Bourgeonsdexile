extends Node

##How sensitive is mouse movement
var mouse_sensitivity = 1.0

var debug_console : DebugConsole

func _ready() -> void:
	##Clicks on e.g. Area2Ds (Clickables) will only trigger on topmost item
	get_viewport().physics_object_picking_first_only = true
	get_viewport().physics_object_picking_sort = true
	
	if OS.has_feature("debug"):
		debug_console = load("res://components/debug/debug_console.tscn").instantiate()
		add_child(debug_console)

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
## Only enabled in debug builds
func _debug_inputs(event : InputEvent) -> void :
	if event.is_action_pressed("debug_speed_up"):
		Engine.time_scale *= 2
		print_debug("Speed up x", Engine.time_scale)
	elif event.is_action_pressed("debug_speed_down"):
		Engine.time_scale /= 2
		print_debug("Speed down x", Engine.time_scale)
	elif Input.is_action_just_pressed_by_event("debug_next", event):
		SignalManager.obstacle_cleared.emit()
		SignalManager.next_panel.emit()
	elif Input.is_action_just_pressed_by_event("debug_toggle_console", event):
		debug_console.toggle()
	
