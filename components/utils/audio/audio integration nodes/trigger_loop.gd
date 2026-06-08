class_name TriggerLoopZone
extends VisibleOnScreenNotifier2D

@export var loop_name: AudioConfiguration.loop_type
@export var loop_mode: trigger_mode = trigger_mode.play_loop
@export var start_loop_on_enter_screen: bool = true

enum trigger_mode{
	play_loop,
	stop_loop,
	update_last_walk_loop,
	stop_walking_loop,
}

func _ready() -> void:
	if start_loop_on_enter_screen:
		self.screen_entered.connect(trigger_loop)

func trigger_loop():
	if loop_mode == trigger_mode.play_loop:
		AudioManager.play_loop(loop_name)
	elif loop_mode == trigger_mode.stop_loop:
		AudioManager.stop_loop(loop_name)
	elif loop_mode == trigger_mode.update_last_walk_loop:
		AudioManager.update_last_walking_loop(loop_name)
	elif loop_mode == trigger_mode.stop_walking_loop:
		AudioManager.free_walking_loop(loop_name)
