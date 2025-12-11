extends Node

var current_scene : Node = null

var paused : bool = false

func _ready():
	#InputManager.cancel_pressed.connect(_on_cancel_pressed)
	
	process_mode = ProcessMode.PROCESS_MODE_ALWAYS
	var root = get_tree().root
	# Using a negative index counts from the end, so this gets the last child node of `root`.
	current_scene = root.get_child(-1)


## Loads next campaign level
func next_level():
	pass

## Load scene via path of PackedScene
func goto_scene(path):
	_deferred_goto_scene.call_deferred(path)
	print("Called loading ", path)

## Load scene deferred execution
func _deferred_goto_scene(path):
	# It is now safe to remove the current scene.
	current_scene.free()

	# Load the new scene.
	var s : Resource
	if path is String :
		s = ResourceLoader.load(path)
	elif path is PackedScene :
		s = path
	
	current_scene = s.instantiate()
	get_tree().root.add_child(current_scene)

	# Optionally, to make it compatible with the SceneTree.change_scene_to_file() API.
	get_tree().current_scene = current_scene
	
	
	# Resume game
	resume_game()
	print("Loaded ", path)

func reload_scene():
	goto_scene(get_tree().current_scene.scene_file_path)

## Pause game
func pause_game():
	get_tree().paused = true
	paused = true

## Resume game
func resume_game():
	get_tree().paused = false
	paused = false
	
## Quit game 
func quit_game():
	print_orphan_nodes()
	get_tree().quit()
	
## Handle cancel key press
func _on_cancel_pressed():
	pass

## Show settings
func open_settings():
	pass
