class_name StopSfx
extends VisibleOnScreenNotifier2D

@export var stop_all_sfx: bool = true

func _ready() -> void:
	if stop_all_sfx:
		screen_entered.connect(stop_sfx)
	else :
		screen_entered.connect(stop_last_sfx)

func stop_sfx():
	AudioManager._stop_all_sfx()

func stop_last_sfx():
	AudioManager.stop_last_sfx_saved()
