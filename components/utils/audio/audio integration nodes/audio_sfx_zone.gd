class_name AudioSfxZone
extends VisibleOnScreenNotifier2D

@export var use_audio_stream: bool = false
@export var sfx: AudioConfiguration.sfx_type
@export var stream: AudioStream
@export var linear_volume: float = 1
@export var min_pitch: float = 1
@export var max_pitch: float = 1

func _ready() -> void:
	if !use_audio_stream:
		screen_entered.connect(play_sfx)
	else:
		screen_entered.connect(play_stream)

func play_sfx():
	AudioManager.play_sfx(sfx)

func play_stream():
	AudioManager.play_audio_stream(stream, linear_volume, min_pitch, max_pitch)
