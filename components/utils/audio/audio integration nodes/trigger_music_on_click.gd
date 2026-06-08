class_name TriggerMusicOnClick
extends Node

@export var clickables : Array[Clickable]
@export var music: AudioConfiguration.music_type

func _ready() -> void:
	for clickable in clickables:
		clickable.clicked.connect(trigger_music)
		

func trigger_music():
	AudioManager.play_music(music)
	for clickable in clickables:
		clickable.clicked.disconnect(trigger_music)
