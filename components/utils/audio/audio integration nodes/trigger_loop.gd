class_name TriggerLoopZone
extends VisibleOnScreenNotifier2D

@export var loop_name: AudioConfiguration.loop_type
@export var stop_loop: bool = false

func _ready() -> void:
	self.screen_entered.connect(trigger_loop)

func trigger_loop():
	if !stop_loop:
		AudioManager.play_loop(loop_name)
	else:
		AudioManager.stop_loop(loop_name)
