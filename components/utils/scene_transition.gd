extends Node

var target_scene_path : String

var loading_status : int
var progress : Array[float]

@export var progress_bar : ProgressBar

func _ready() -> void:
	set_process(false)
	
func _process(_delta: float) -> void:
	# Update the status:
	loading_status = ResourceLoader.load_threaded_get_status(target_scene_path, progress)
	
	# Check the loading status:
	match loading_status:
		ResourceLoader.THREAD_LOAD_IN_PROGRESS:
			progress_bar.value = progress[0] * 100 # Change the ProgressBar value
		ResourceLoader.THREAD_LOAD_LOADED:
			set_process(false)
			# When done loading, change to the target scene:
			get_tree().change_scene_to_packed(ResourceLoader.load_threaded_get(target_scene_path))
		ResourceLoader.THREAD_LOAD_FAILED:
			print("Error. Could not load Resource")

func load_scene(target_scene_path : String):
	# Request to load the target scene:
	ResourceLoader.load_threaded_request(target_scene_path)
	set_process(true)
