class_name  TriggerSoundConsecutive
extends VisibleOnScreenNotifier2D


@export var delay_time: float = 10

@export var sfx_list: Array[AudioStream]
@export var linear_volume: float = 1
@export var min_pitch: float = 1
@export var max_pitch: float = 1

var current_scene : Node = null


func _ready() -> void:
	current_scene = SceneManager.current_scene
	self.screen_entered.connect(_triger_sound)


func _triger_sound():
	if current_scene == SceneManager.current_scene:
		AudioManager.play_audio_stream(sfx_list[randi_range(0,sfx_list.size()-1)], linear_volume, min_pitch, max_pitch, false)
		await get_tree().create_timer(delay_time).timeout
		_triger_sound()
