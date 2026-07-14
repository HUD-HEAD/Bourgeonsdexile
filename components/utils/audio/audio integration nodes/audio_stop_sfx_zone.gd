class_name StopSfx
extends VisibleOnScreenNotifier2D

@export var stop_all_sfx: bool = true
@export var node_to_disable: Node2D

func _ready() -> void:
	if stop_all_sfx:
		screen_entered.connect(stop_sfx)
	else :
		screen_entered.connect(stop_last_sfx)

func stop_sfx():
	AudioManager._stop_all_sfx()
	disable_node()

func stop_last_sfx():
	AudioManager.stop_last_sfx_saved()
	disable_node()

func disable_node():
	if node_to_disable != null:
		node_to_disable.visible = false
