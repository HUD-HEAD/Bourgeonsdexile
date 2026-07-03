class_name TriggerMusicOnClick
extends Node

@export var clickables : Array[Clickable]
@export var music: AudioConfiguration.music_type
@export var delay: float = -1

func _ready() -> void:
	for clickable in clickables:
		clickable.clicked.connect(trigger_music)
		

func trigger_music():
	if delay == -1:
		AudioManager.play_music(music)
	else :
		await get_tree().create_timer(delay).timeout
		AudioManager.play_music(music)
	
	for clickable in clickables:
		clickable.clicked.disconnect(trigger_music)
