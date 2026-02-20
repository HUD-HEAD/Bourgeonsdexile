extends Node


var audio_ambient : AudioStreamPlayer
var audio_sfx : AudioStreamPlayer


func _ready() -> void:
	audio_ambient = AudioStreamPlayer.new()
	add_child(audio_ambient)
	
	audio_sfx = AudioStreamPlayer.new()
	add_child(audio_sfx)
