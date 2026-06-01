class_name TriggerLoopZone
extends VisibleOnScreenNotifier2D

@export var loop_name: AudioConfiguration.loop_type
@export var loop_mode: trigger_mode = trigger_mode.play_loop

enum trigger_mode{
	play_loop,
	stop_loop,
	update_last_walk_loop,
	
}

func _ready() -> void:
	self.screen_entered.connect(trigger_loop)

func trigger_loop():
	if loop_mode == trigger_mode.play_loop:
		AudioManager.play_loop(loop_name)
	elif loop_mode == trigger_mode.stop_loop:
		AudioManager.stop_loop(loop_name)
	elif loop_mode == trigger_mode.update_last_walk_loop:
		AudioManager.update_last_walking_loop(loop_name)
