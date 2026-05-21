extends Node

var checkpoints_config: CheckpointConfiguration

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	checkpoints_config = preload("res://components/utils/save_system/save_system_configurations/checkpoints_configuration.tres")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func load_game(data :CheckpointData):
	
	pass


func debug_load_checkpoint():
	#load_game(debug_checkpoint)
	SceneManager.goto_scene(checkpoints_config.get_scene_path(checkpoints_config.debug_checkpoint))
	pass
