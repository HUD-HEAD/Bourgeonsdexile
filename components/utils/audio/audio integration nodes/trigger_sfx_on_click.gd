class_name TriggerSfxOnClick
extends Node

@export var clickables : Array[Clickable]
@export var sfx: AudioConfiguration.sfx_type
@export var play_sfx_once: bool = false
@export var use_audio_stream: bool = false
@export_group("Stream Config")
@export var stream: AudioStream
@export var linear_volume: float = 1
@export var min_pitch: float = 1
@export var max_pitch: float = 1

func _ready() -> void:
	for clickable in clickables:
		clickable.clicked.connect(play_sfx)

func play_sfx():
	if use_audio_stream:
		AudioManager.play_audio_stream(stream, linear_volume, min_pitch, max_pitch)
	else:
		AudioManager.play_sfx(sfx)
	
	if play_sfx_once:
		for clickable in clickables:
			clickable.clicked.disconnect(play_sfx)
