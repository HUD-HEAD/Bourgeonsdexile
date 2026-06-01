class_name LoopZone
extends VisibleOnScreenNotifier2D

@export var loop_name: AudioConfiguration.loop_type

func _ready() -> void:
	self.screen_entered.connect(fade_in)
	self.screen_exited.connect(fade_out)

func fade_out():
	AudioManager.stop_loop(loop_name)

func fade_in():
	AudioManager.play_loop(loop_name)
