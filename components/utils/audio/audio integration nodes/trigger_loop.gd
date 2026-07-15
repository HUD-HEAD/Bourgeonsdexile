class_name TriggerLoopZone
extends VisibleOnScreenNotifier2D

@export var loop_name: AudioConfiguration.loop_type
@export var loop_mode: trigger_mode = trigger_mode.play_loop
@export var start_loop_on_enter_screen: bool = true
@export var fade_out_final_volume: float = 0

enum trigger_mode{
	play_loop,
	stop_loop,
	update_last_walk_loop,
	stop_walking_loop,
	update_last_walk_loop_on_ready,
}

func _enter_tree() -> void:
	if loop_mode == trigger_mode.update_last_walk_loop_on_ready:
		AudioManager.last_walking_loop = loop_name
		await get_tree().create_timer(0.1).timeout
		AudioManager._force_to_play_loop(loop_name)

func _ready() -> void:
	if start_loop_on_enter_screen:
		self.screen_entered.connect(trigger_loop)

func trigger_loop():
	if loop_mode == trigger_mode.play_loop:
		AudioManager.play_loop(loop_name)
	elif loop_mode == trigger_mode.stop_loop:
		AudioManager.stop_loop(loop_name, fade_out_final_volume)
	elif loop_mode == trigger_mode.update_last_walk_loop:
		AudioManager.update_last_walking_loop(loop_name)
	elif loop_mode == trigger_mode.stop_walking_loop:
		AudioManager.free_walking_loop(loop_name)

func play_loop():
	AudioManager.play_loop(loop_name)

func stop_loop():
	AudioManager.stop_loop(loop_name)
	
