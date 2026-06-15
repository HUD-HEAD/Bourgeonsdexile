class_name TriggerSfxList
extends Node

@export var clickables : Array[Clickable]
@export var stream_list: Array[AudioStream]
@export var linear_volume: float = 1
@export var min_pitch: float = 1
@export var max_pitch: float = 1
@export var save_sfx_id: bool = false

var index: int = 0

func _ready() -> void:
	for clickable in clickables:
		clickable.clicked.connect(play_sfx)

func play_sfx():
	if stream_list.size() > index:
		AudioManager.play_audio_stream(stream_list[index], linear_volume, min_pitch, max_pitch, save_sfx_id)
		index += 1
