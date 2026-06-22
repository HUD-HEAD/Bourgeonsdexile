class_name AudioMusicTimer

extends VisibleOnScreenNotifier2D

@export var first_music_name: AudioConfiguration.music_type
@export var second_music_name: AudioConfiguration.music_type
@export var delay_to_play_second_theme: float
@export var trigger_on_enter_zone: bool = true

func _ready() -> void:
	if trigger_on_enter_zone:
		screen_entered.connect(change_music)

func change_music():
	AudioManager.play_music(first_music_name)
	
	await get_tree().create_timer(delay_to_play_second_theme).timeout
	AudioManager.play_music(second_music_name)
