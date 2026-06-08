class_name AudioMusicTransition

extends VisibleOnScreenNotifier2D

@export var music_name: AudioConfiguration.music_type
@export var trigger_on_enter_zone: bool = true

func _ready() -> void:
	if trigger_on_enter_zone:
		screen_entered.connect(change_music)

func change_music():
	AudioManager.play_music(music_name)

func stop_music():
	AudioManager.stop_music()
