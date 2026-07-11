extends Node

##How sensitive is mouse movement
var mouse_sensitivity = 1.0

var debug_console : DebugConsole

var confine_mouse : bool

func _ready() -> void:
	#Can detect input on pause game
	process_mode = PROCESS_MODE_ALWAYS
	
	##Clicks on e.g. Area2Ds (Clickables) will only trigger on topmost item
	get_viewport().physics_object_picking_first_only = true
	get_viewport().physics_object_picking_sort = true
	
	#Check and apply mouse confined in non-debug builds
	confine_mouse = !OS.is_debug_build()
	show_mouse()
	
	if OS.has_feature("debug"):
		debug_console = load("res://components/debug/debug_console.tscn").instantiate()
		add_child(debug_console)

func show_mouse():
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED if confine_mouse \
			else Input.MOUSE_MODE_VISIBLE

func hide_mouse():
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED_HIDDEN if confine_mouse \
			else Input.MOUSE_MODE_HIDDEN

func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_pressed("exit"):
		if OS.has_feature("debug"):
			if debug_console.visible:
				debug_console.toggle()
		
		PauseController.show_pause_menu()
	
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
	elif event.is_action_pressed("debug_next"):
		SignalManager.obstacle_cleared.emit()
		SignalManager.next_panel.emit()
	elif event.is_action_pressed("debug_toggle_console"):
		debug_console.toggle()
	elif event.is_action_pressed("debug_load_checkpoint"):
		SaveManager.debug_load_checkpoint()
	elif event.is_action_pressed("debug_autosolve_puzzle"):
		if is_instance_valid(GameManager.current_puzzle):
			GameManager.current_puzzle.autosolve_puzzle()
	
