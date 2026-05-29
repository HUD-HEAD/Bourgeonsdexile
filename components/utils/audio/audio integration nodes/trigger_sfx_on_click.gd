class_name TriggerSfxOnClick
extends Node

@export var clickables : Array[Clickable]
@export var use_audio_stream: bool = false
@export var sfx: AudioConfiguration.sfx_type
@export var stream: AudioStream
@export var play_sfx_once: bool = false

func _ready() -> void:
	for clickable in clickables:
		clickable.clicked.connect(play_sfx)

func play_sfx():
	if use_audio_stream:
		AudioManager.play_audio_stream(stream)
	else:
		AudioManager.play_sfx(sfx)
	
	if play_sfx_once:
		for clickable in clickables:
			clickable.clicked.disconnect(play_sfx)
