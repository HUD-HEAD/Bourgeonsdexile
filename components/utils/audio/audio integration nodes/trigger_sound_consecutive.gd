class_name  TriggerSoundConsecutive
extends VisibleOnScreenNotifier2D


@export var delay_time: float = 10
var timer: float = 0

@export var sfx_list: Array[AudioStream]
@export var linear_volume: float = 1
@export var min_pitch: float = 1
@export var max_pitch: float = 1

var current_scene : Node = null
var start_playing_sfx: bool = false

func _ready() -> void:
	current_scene = SceneManager.current_scene
	#self.screen_entered.connect(_triger_sound)
	self.screen_entered.connect(_start_sfx)


func _start_sfx():
	start_playing_sfx = true
	timer = delay_time
	self.screen_entered.disconnect(_start_sfx)

# Timer didnt stop when the game was paused, now we calculate the timer manually in process func
#func _triger_sound():
	#if current_scene == SceneManager.current_scene:
		#AudioManager.play_audio_stream(sfx_list[randi_range(0,sfx_list.size()-1)], linear_volume, min_pitch, max_pitch, false)
		#await get_tree().create_timer(delay_time, true).timeout
		#_triger_sound()


func _process(delta: float) -> void:
	if start_playing_sfx:
		if current_scene == SceneManager.current_scene:
			timer += delta
			if timer >= delay_time:
				timer = 0
				AudioManager.play_audio_stream(sfx_list[randi_range(0,sfx_list.size()-1)], linear_volume, min_pitch, max_pitch, false)
		else:
			start_playing_sfx = false
