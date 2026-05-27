class_name AudioMusicTransition

extends VisibleOnScreenNotifier2D

@export var music_name: AudioConfiguration.music_type

func _ready() -> void:
	screen_entered.connect(change_music)

func change_music():
	AudioManager.play_music(music_name)
